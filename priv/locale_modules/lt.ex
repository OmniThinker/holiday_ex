defmodule HolidayEx.LT do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Naujieji metai"
  end

  def holiday(%Date{month: 2, day: 16}) do
    "Valstybės atkūrimo diena"
  end

  def holiday(%Date{month: 3, day: 11}) do
    "Nepriklausomybės atkūrimo diena"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Darbininkų diena"
  end

  def holiday(%Date{month: 6, day: 24}) do
    "Joninės"
  end

  def holiday(%Date{month: 7, day: 6}) do
    "Valstybės diena"
  end

  def holiday(%Date{month: 8, day: 15}) do
    "Žolinė"
  end

  def holiday(%Date{month: 11, day: 1}) do
    "Visų šventųjų diena"
  end

  def holiday(%Date{month: 12, day: 24}) do
    "Šv. Kūčios"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Šv. Kalėdos"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "Antroji Kalėdų diena"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, 0) == date -> "Šv. Velykos"
      Date.add(easter_date, 1) == date -> "Antroji Velykų diena"
      true -> nil
    end
  end
end