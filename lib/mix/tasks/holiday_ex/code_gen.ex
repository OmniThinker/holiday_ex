defmodule Mix.Tasks.HolidayEx.CodeGen do
  use Mix.Task
  alias HolidayEx.Extract

  @locales HolidayEx.Extract.extract_locales()
  @locale_files HolidayEx.Extract.extract_locale_files()
  @holiday_map Enum.reduce(@locale_files, %{}, fn locale_file, acc ->
                 file_path = Path.join([:code.priv_dir(:holiday_ex), "definitions", locale_file])
                 holidays = YamlElixir.read_from_file!(file_path)
                 months = Map.get(holidays, "months")
                 locale = HolidayEx.Extract.extract_locale(locale_file) |> String.to_atom()
                 Map.put(acc, locale, months)
               end)

  def run(_) do
    output_folder = "./priv/locale_modules"
    output_path = Path.absname(output_folder)
    
    for locale <- @locales do
      filename = output_path
      module_ast(locale)
      |> 
    end
  end

  @spec module_ast(locale :: atom()) :: Macro.t()
  def module_ast(locale) do
    date_func = dates(locale) |> date_ast
    easter_func = easter_offsets(locale) |> easter_ast

    locale_name = locale |> Atom.to_string() |> String.upcase()
    module_name = Module.concat(HolidayEx, locale_name)

    quote do
      defmodule unquote(module_name) do
        @spec holiday(date :: Date.t()) :: binary()
        unquote_splicing(date_func)
        unquote(easter_func)
      end
    end
  end

  def locales(), do: @locales
  def locale_files(), do: @locale_files
  def holiday_map(), do: @holiday_map

  @type date_tuples :: [{month :: integer(), day :: integer(), name :: binary()}]

  @spec dates(atom()) :: date_tuples()
  def dates(locale) do
    Map.get(holiday_map(), locale)
    |> Enum.filter(fn {month, _} -> month > 0 end)
    |> Enum.flat_map(fn {month, days} ->
      Enum.map(days, fn day -> {month, day} end)
    end)
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
    |> Map.get(0)
    |> Enum.map(fn %{"function" => func, "name" => name} ->
      offset = read_offset(func)
      {name, offset}
    end)
  end

  @spec easter_ast(easter_offset_tuples()) :: Macro.t()
  def easter_ast(offset_tuples) do
    offset_conditions =
      Enum.map(offset_tuples, fn {name, offset} ->
        quote do
          Date.add(easter_date, unquote(offset)) == date -> unquote(name)
        end
      end)

    default_condition =
      quote do
        true -> nil
      end

    conditions = offset_conditions ++ [default_condition]

    quote do
      def holiday(%Date{year: year} = date) do
        easter_date = HolidayEx.Utils.easter(year)

        cond do
          (unquote_splicing(conditions))
        end
      end
    end
  end

  @spec read_offset(binary()) :: integer()
  defp read_offset(<<"easter(year)", "">>), do: 0
  defp read_offset(<<"easter(year)", offset::binary>>), do: String.to_integer(offset)
end
