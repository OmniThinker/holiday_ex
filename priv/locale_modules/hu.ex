defmodule HolidayEx.HU do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Újév"
  end

  def holiday(%Date{month: 3, day: 15}) do
    "1848/49-es forradalom és szabadságharc ünnepe"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "A munka ünnepe"
  end

  def holiday(%Date{month: 8, day: 20}) do
    "Az államalapítás ünnepe"
  end

  def holiday(%Date{month: 10, day: 23}) do
    "1956-os forradalom és szabadságharc ünnepe"
  end

  def holiday(%Date{month: 11, day: 1}) do
    "Mindenszentek"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Karácsony"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "Karácsony"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, 1) == date -> "Húsvét hétfő"
      Date.add(easter_date, 50) == date -> "Pünkösd hétfő"
      true -> nil
    end
  end
end