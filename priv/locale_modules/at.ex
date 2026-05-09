defmodule HolidayEx.AT do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Neujahrstag"
  end

  def holiday(%Date{month: 1, day: 6}) do
    "Heilige Drei Könige"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Staatsfeiertag"
  end

  def holiday(%Date{month: 8, day: 15}) do
    "Mariä Himmelfahrt"
  end

  def holiday(%Date{month: 10, day: 26}) do
    "Nationalfeiertag"
  end

  def holiday(%Date{month: 11, day: 1}) do
    "Allerheiligen"
  end

  def holiday(%Date{month: 12, day: 8}) do
    "Mariä Empfägnis"
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
      Date.add(easter_date, 1) == date -> "Ostermontag"
      Date.add(easter_date, 39) == date -> "Christi Himmelfahrt"
      Date.add(easter_date, 50) == date -> "Pfingstmontag"
      Date.add(easter_date, 60) == date -> "Fronleichnam"
      true -> nil
    end
  end
end