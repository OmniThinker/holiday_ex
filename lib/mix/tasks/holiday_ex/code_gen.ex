defmodule Mix.Tasks.HolidayEx.CodeGen do
  use Mix.Task

  @locales HolidayEx.Extract.extract_locales()
  @locale_files HolidayEx.Extract.extract_locale_files()
  @holiday_map Enum.reduce(@locale_files, %{}, fn locale_file, acc ->
                 file_path = Path.join([:code.priv_dir(:holiday_ex), "definitions", locale_file])
                 holidays = YamlElixir.read_from_file!(file_path)
                 months = Map.get(holidays, "months")
                 locale = HolidayEx.Extract.extract_locale(locale_file) |> String.to_atom()
                 Map.put(acc, locale, months)
               end)
  @method_map Enum.reduce(@locale_files, %{}, fn locale_file, acc ->
                file_path = Path.join([:code.priv_dir(:holiday_ex), "definitions", locale_file])
                holidays = YamlElixir.read_from_file!(file_path)
                methods = Map.get(holidays, "methods")
                locale = HolidayEx.Extract.extract_locale(locale_file) |> String.to_atom()
                Map.put(acc, locale, methods)
              end)

  def run(_) do
    output_folder = "./priv/locale_modules"
    output_path = Path.absname(output_folder)

    for locale <- @locales do
      filename = Path.join(output_path, Atom.to_string(locale) <> ".ex")

      macro_str =
        module_ast(locale)
        |> Macro.to_string()

      methods = (Map.get(method_map(), locale) || %{}) |> Map.values() |> Enum.join()

      full_file =
        if methods do
          macro_str <> methods
        else
          macro_str
        end

      File.write!(filename, full_file)
    end
  end

  @spec module_ast(locale :: atom()) :: Macro.t()
  def module_ast(locale) do
    date_func = dates(locale) |> date_ast
    easter_conds = easter_offsets(locale) |> easter_conditions()
    week_conds = week_dates(locale) |> week_conditions
    special_conds = special_dates(locale) |> special_date_conditions

    default_condition =
      quote do
        true -> nil
      end

    conditions =
      List.flatten([
        easter_conds,
        week_conds,
        special_conds,
        [default_condition]
      ])

    locale_name = locale |> Atom.to_string() |> String.upcase()
    module_name = Module.concat(HolidayEx, locale_name)

    cond_ast = {:cond, [], [[do: conditions]]}

    quote do
      defmodule unquote(module_name) do
        @spec holiday(date :: Date.t()) :: binary()
        unquote_splicing(date_func)

        def holiday(%Date{year: year} = date) do
          easter_date = HolidayEx.Utils.easter(year)
          unquote(cond_ast)
        end
      end
    end
  end

  def locales(), do: @locales
  def locale_files(), do: @locale_files
  def holiday_map(), do: @holiday_map
  def method_map(), do: @method_map

  @type date_tuples :: [{month :: integer(), day :: integer(), name :: binary()}]

  @spec dates(atom()) :: date_tuples()
  def dates(locale) do
    Map.get(holiday_map(), locale)
    |> Enum.filter(fn {month, _} -> month > 0 end)
    |> Enum.flat_map(fn {month, days} ->
      Enum.map(days, fn day -> {month, day} end)
    end)
    |> Enum.filter(fn {_, mp} -> Map.has_key?(mp, "mday") end)
    |> Enum.map(fn {month, %{"mday" => day, "name" => name}} ->
      {month, day, name}
    end)
  end

  @spec date_ast(date_tuples()) :: Macro.t()
  def date_ast(date_tuples) do
    Enum.map(date_tuples, fn {month, day, name} ->
      quote do
        def holiday(%Date{month: unquote(month), day: unquote(day)}), do: unquote(name)
      end
    end)
  end

  @type easter_offset_tuples :: [{name :: binary(), offset :: integer()}]
  @spec easter_offsets(atom()) :: easter_offset_tuples()
  def easter_offsets(locale) do
    Map.get(holiday_map(), locale)
    |> Map.get(0, [])
    |> Enum.filter(fn %{"function" => func} ->
      String.starts_with?(func, "easter")
    end)
    |> Enum.map(fn %{"function" => func, "name" => name} ->
      offset = read_offset(func)
      {name, offset}
    end)
  end

  @spec easter_conditions(easter_offset_tuples()) :: Macro.t()
  def easter_conditions(offset_tuples) do
    Enum.map(offset_tuples, fn {name, offset} ->
      quote do
        Date.add(easter_date, unquote(offset)) == date -> unquote(name)
      end
    end)
  end

  @type week_date :: {month :: integer(), week :: integer(), day :: integer(), name :: binary()}
  @spec week_dates(locale :: atom()) :: [week_date()]
  def week_dates(locale) do
    Map.get(holiday_map(), locale)
    |> Enum.filter(fn {month, _} -> month > 0 end)
    |> Enum.flat_map(fn {month, days} ->
      Enum.map(days, fn day -> {month, day} end)
    end)
    |> Enum.filter(fn {_, mp} -> Map.has_key?(mp, "wday") end)
    |> Enum.map(fn {month, %{"wday" => day, "week" => week, "name" => name}} ->
      {month, week, day, name}
    end)
  end

  def week_conditions(wds) do
    Enum.map(wds, fn {month, week, day, name} ->
      quote do
        date ==
            HolidayEx.Utils.weekday_to_date(
              year,
              unquote(month),
              unquote(week),
              unquote(day)
            ) ->
          unquote(name)
      end
    end)
  end

  @type special_date :: {month :: integer(), function :: binary(), name :: binary()}
  @spec special_dates(locale :: atom()) :: term()
  def special_dates(locale) do
    Map.get(holiday_map(), locale)
    |> Enum.filter(fn {month, _} -> month > 0 end)
    |> Enum.flat_map(fn {month, days} ->
      Enum.map(days, fn day -> {month, day} end)
    end)
    |> Enum.reject(fn {_, mp} -> Map.has_key?(mp, "mday") || Map.has_key?(mp, "wday") end)
    |> Enum.map(fn {month, %{"function" => function, "name" => name}} ->
      {month, function, name}
    end)
  end

  def special_date_conditions(spec_dates) do
    spec_dates
    |> Enum.map(fn {_, function, name} ->
      func = Code.string_to_quoted!(function)

      quote do
        unquote(func) -> unquote(name)
      end
    end)
  end

  @spec read_offset(binary()) :: integer()
  defp read_offset(<<"easter(year)", "">>), do: 0
  defp read_offset(<<"easter(year)", offset::binary>>), do: String.to_integer(offset)
end
