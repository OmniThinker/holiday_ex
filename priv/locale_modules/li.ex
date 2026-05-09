defmodule HolidayEx.LI do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Neujahrstag"
  end

  def holiday(%Date{month: 1, day: 6}) do
    "Heilige Drei Könige"
  end

  def holiday(%Date{month: 2, day: 2}) do
    "Maria Lichtmess"
  end

  def holiday(%Date{month: 3, day: 19}) do
    "St. Josef"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Tag der Arbeit"
  end

  def holiday(%Date{month: 8, day: 15}) do
    "Staatsfeiertag"
  end

  def holiday(%Date{month: 9, day: 8}) do
    "Maria Geburt"
  end

  def holiday(%Date{month: 11, day: 1}) do
    "Allerheiligen"
  end

  def holiday(%Date{month: 12, day: 8}) do
    "Maria Empfängnis"
  end

  def holiday(%Date{month: 12, day: 24}) do
    "Heilig Abend"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Weihnachten"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "Stefanstag"
  end

  def holiday(%Date{month: 12, day: 31}) do
    "Silvester"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -47) == date -> "Fasnachtsdienstag"
      Date.add(easter_date, -2) == date -> "Karfreitag"
      Date.add(easter_date, 0) == date -> "Ostern"
      Date.add(easter_date, 1) == date -> "Ostermontag"
      Date.add(easter_date, 39) == date -> "Auffahrt"
      Date.add(easter_date, 50) == date -> "Pfingstmontag"
      Date.add(easter_date, 60) == date -> "Fronleichnam"
      true -> nil
    end
  end
end