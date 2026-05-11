defmodule HolidayEx.JP do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "元日"
  end

  def holiday(%Date{month: 2, day: 11}) do
    "建国記念日"
  end

  def holiday(%Date{month: 2, day: 23}) do
    "天皇誕生日"
  end

  def holiday(%Date{month: 4, day: 29}) do
    "昭和の日"
  end

  def holiday(%Date{month: 5, day: 3}) do
    "憲法記念日"
  end

  def holiday(%Date{month: 5, day: 4}) do
    "みどりの日"
  end

  def holiday(%Date{month: 5, day: 5}) do
    "こどもの日"
  end

  def holiday(%Date{month: 11, day: 3}) do
    "文化の日"
  end

  def holiday(%Date{month: 11, day: 23}) do
    "勤労感謝の日"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      date == HolidayEx.Utils.weekday_to_date(year, 1, 2, 1) -> "成人の日"
      date == HolidayEx.Utils.weekday_to_date(year, 7, 3, 1) -> "海の日"
      date == HolidayEx.Utils.weekday_to_date(year, 9, 3, 1) -> "敬老の日"
      date == HolidayEx.Utils.weekday_to_date(year, 10, 2, 1) -> "体育の日"
      date == jp_substitute_holiday(year, 1, 1) -> "振替休日"
      date == jp_substitute_holiday(year, 2, 11) -> "振替休日"
      date == jp_vernal_equinox_day(year) -> "春分の日"
      date == jp_substitute_holiday(jp_vernal_equinox_day(year)) -> "振替休日"
      date == jp_substitute_holiday(year, 4, 29) -> "振替休日"
      date == jp_substitute_holiday(year, 5, 3) -> "振替休日"
      date == jp_substitute_holiday(year, 5, 4) -> "振替休日"
      date == jp_substitute_holiday(year, 5, 5) -> "振替休日"
      date == jp_substitute_holiday(year, 7, calculate_day_of_month(year, 7, 3, 1)) -> "振替休日"
      date == jp_mountain_holiday(year) -> "山の日"
      date == jp_substitute_holiday(jp_mountain_holiday(year)) -> "振替休日"
      date == jp_substitute_holiday(year, 9, calculate_day_of_month(year, 9, 3, 1)) -> "振替休日"
      date == jp_citizons_holiday(year) -> "国民の休日"
      date == jp_national_culture_day(year) -> "秋分の日"
      date == jp_substitute_holiday(jp_national_culture_day(year)) -> "振替休日"
      date == jp_substitute_holiday(year, 10, calculate_day_of_month(year, 10, 2, 1)) -> "振替休日"
      date == jp_substitute_holiday(year, 11, 3) -> "振替休日"
      date == jp_substitute_holiday(year, 11, 23) -> "振替休日"
      date == jp_substitute_holiday(year, 12, 23) -> "振替休日"
      true -> nil
    end
  end

  defp jp_citizens_holiday(year) when year < 2003, do: nil

  defp jp_citizens_holiday(year) do
    ncd = jp_national_culture_day(year)
    if Date.day_of_week(ncd) == 3, do: Date.add(ncd, -1), else: nil
  end

  defp jp_mountain_holiday(year) when year < 2016, do: nil
  defp jp_mountain_holiday(year), do: Date.new!(year, 8, 11)

  defp jp_national_culture_day(year) when year in 1851..1899 do
    compute_jp_date(year, 9, 22.2588)
  end

  defp jp_national_culture_day(year) when year in 1900..1979 do
    compute_jp_date(year, 9, 23.2588)
  end

  defp jp_national_culture_day(year) when year in 1980..2099 do
    compute_jp_date(year, 9, 23.2488)
  end

  defp jp_national_culture_day(year) when year in 2100..2150 do
    compute_jp_date(year, 9, 24.2488)
  end

  defp jp_national_culture_day(_year), do: raise(ArgumentError, "Out of range")

  defp jp_next_weekday(date) do
    is_holiday =
      Enum.any?(holidays_by_month()[date.month] || [], fn holiday ->
        holiday[:mday] == date.day
      end)

    if Date.day_of_week(date) == 7 || is_holiday do
      jp_next_weekday(Date.add(date, 1))
    else
      date
    end
  end

  defp jp_substitute_holiday(nil), do: nil

  defp jp_substitute_holiday(date) do
    if Date.day_of_week(date) == 7, do: jp_next_weekday(Date.add(date, 1)), else: nil
  end

  defp jp_vernal_equinox_day(year) when year in 1851..1899 do
    compute_jp_date(year, 3, 19.8277)
  end

  defp jp_vernal_equinox_day(year) when year in 1900..1979 do
    compute_jp_date(year, 3, 20.8357)
  end

  defp jp_vernal_equinox_day(year) when year in 1980..2099 do
    compute_jp_date(year, 3, 20.8431)
  end

  defp jp_vernal_equinox_day(year) when year in 2100..2150 do
    compute_jp_date(year, 3, 21.8510)
  end

  defp jp_vernal_equinox_day(_year), do: raise(ArgumentError, "Out of range")

  defp compute_jp_date(year, month, base_day) do
    day =
      (base_day + 0.242194 * (year - 1980) - div(year - 1980, 4))
      |> floor()

    Date.new!(year, month, day)
  end
end
