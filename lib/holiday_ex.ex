defmodule HolidayEx do
  @moduledoc """
  HolidayEx is a library for checking whether a date falls within a publicly observed holiday.

  This module is meant as a replacement for the Holiday library. It builds on that library, but instead of
  messing around with genservers and applications we generate a lookup map using yml files.
  Most of the credit for the actual logic goes to CoderDenis.

  We use  yml files for the holidays, so any discrepancy found in the library can be solved with a pull request 
  adding the relevant data to those files.
  """
  @locales HolidayEx.Extract.extract_locales()
  @locale_files HolidayEx.Extract.extract_locale_files()
  # In reality it needs to be part of the locales list
  @type locale :: atom()

  @holiday_map Enum.reduce(@locale_files, %{}, fn locale_file, acc ->
                 file_path = Path.join([:code.priv_dir(:holiday_ex), "definitions", locale_file])
                 holidays = YamlElixir.read_from_file!(file_path)
                 months = Map.get(holidays, "months")
                 locale = HolidayEx.Extract.extract_locale(locale_file) |> String.to_atom()
                 Map.put(acc, locale, months)
               end)

  @doc """
  The Holiday.holiday? function takes a `date`, and a supported `locale` as an atom and 
  produces a `boolean` of whether the date is a publicly observed holiday or not.

  ## Examples

      iex> HolidayEx.holiday?(~D[2026-01-01], :no)
      true

      iex> HolidayEx.holiday?(~D[2026-02-01], :no)
      false
  """
  @spec holiday?(Date.t(), locale()) :: boolean()
  def holiday?(%Date{year: year, month: month, day: day} = date, locale) when is_atom(locale) do
    if !MapSet.member?(@locales, locale) do
      raise ArgumentError, "locale is not in the available locales"
    end

    locale_dates = Map.get(@holiday_map, locale)
    easter_date = easter(year)

    standard_holiday? =
      locale_dates
      |> Map.get(month, [])
      |> Enum.find(fn x -> Map.get(x, "mday") == day end)
      |> is_map

    easter_dates =
      Map.get(locale_dates, 0)
      |> Enum.map(fn %{"function" => func_str} -> func_str end)
      |> Enum.map(&read_offset/1)
      |> Enum.map(&String.to_integer/1)
      |> Enum.map(fn x -> Date.shift(easter_date, day: x) end)

    easter? = date in easter_dates
    standard_holiday? || easter?
  end

  defp read_offset(<<"easter(year)", "">>) do
    "0"
  end

  defp read_offset(<<"easter(year)", offset::binary>>) do
    offset
  end

  defp easter(year) do
    y = year
    a = rem(y, 19)
    b = div(y, 100)
    c = rem(y, 100)
    d = div(b, 4)
    e = rem(b, 4)
    f = (b + 8) |> div(25)
    g = (b - f + 1) |> div(3)
    h = (19 * a + b - d - g + 15) |> rem(30)
    i = div(c, 4)
    k = rem(c, 4)
    l = (32 + 2 * e + 2 * i - h - k) |> rem(7)
    m = (a + 11 * h + 22 * l) |> div(451)

    month = (h + l - 7 * m + 114) |> div(31)
    day = ((h + l - 7 * m + 114) |> rem(31)) + 1

    Date.new!(year, month, day)
  end
end
