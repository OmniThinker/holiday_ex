defmodule HolidayEx.FR do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Jour de l'an"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Fête du travail"
  end

  def holiday(%Date{month: 5, day: 8}) do
    "Victoire 1945"
  end

  def holiday(%Date{month: 7, day: 14}) do
    "Fête nationale"
  end

  def holiday(%Date{month: 8, day: 15}) do
    "Assomption"
  end

  def holiday(%Date{month: 11, day: 1}) do
    "Toussaint"
  end

  def holiday(%Date{month: 11, day: 11}) do
    "Armistice 1918"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Noël"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, 0) == date -> "Pâques"
      Date.add(easter_date, 1) == date -> "Lundi de Pâques"
      Date.add(easter_date, 39) == date -> "Ascension"
      Date.add(easter_date, 49) == date -> "Pentecôte"
      Date.add(easter_date, 50) == date -> "Lundi de Pentecôte"
      true -> nil
    end
  end
end