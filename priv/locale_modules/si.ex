defmodule HolidayEx.SI do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "novo leto"
  end

  def holiday(%Date{month: 2, day: 8}) do
    "Prešernov dan, slovenski kulturni praznik"
  end

  def holiday(%Date{month: 4, day: 27}) do
    "dan upora proti okupatorju"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "praznik dela"
  end

  def holiday(%Date{month: 5, day: 2}) do
    "praznik dela"
  end

  def holiday(%Date{month: 6, day: 25}) do
    "dan državnosti"
  end

  def holiday(%Date{month: 8, day: 15}) do
    "Marijino vnebovzetje"
  end

  def holiday(%Date{month: 10, day: 31}) do
    "dan reformacije"
  end

  def holiday(%Date{month: 11, day: 1}) do
    "dan spomina na mrtve"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "božič"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "dan samostojnosti in enotnosti"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, 0) == date -> "velikonočna nedelja"
      Date.add(easter_date, 1) == date -> "velikonočni ponedeljek"
      Date.add(easter_date, 49) == date -> "binkošti"
      true -> nil
    end
  end
end