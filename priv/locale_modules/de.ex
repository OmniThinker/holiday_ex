defmodule HolidayEx.DE do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Neujahrstag"
  end

  def holiday(%Date{month: 1, day: 6}) do
    "Heilige Drei Könige"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Tag der Arbeit"
  end

  def holiday(%Date{month: 8, day: 15}) do
    "Mariä Himmelfahrt"
  end

  def holiday(%Date{month: 8, day: 8}) do
    "Friedensfest"
  end

  def holiday(%Date{month: 10, day: 3}) do
    "Tag der Deutschen Einheit"
  end

  def holiday(%Date{month: 10, day: 31}) do
    "Reformationstag"
  end

  def holiday(%Date{month: 11, day: 1}) do
    "Allerheiligen"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "1. Weihnachtstag"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "2. Weihnachtstag"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -2) == date -> "Karfreitag"
      Date.add(easter_date, 1) == date -> "Ostermontag"
      Date.add(easter_date, 39) == date -> "Christi Himmelfahrt"
      Date.add(easter_date, 50) == date -> "Pfingstmontag"
      Date.add(easter_date, 60) == date -> "Fronleichnam"
      date == de_buss_und_bettag(year) -> "Buß- und Bettag"
      true -> nil
    end
  end

  defp de_buss_und_bettag(year) do
    date = %Date{year: year, month: 11, day: 23}
    weekday = Date.day_of_week(date)
    days_back = rem(weekday - 3 + 6, 7) + 1
    Date.add(date, -days_back)
  end
end
