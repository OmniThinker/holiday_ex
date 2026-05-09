defmodule HolidayEx.NL do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Nieuwjaar"
  end

  def holiday(%Date{month: 4, day: 27}) do
    "Koningsdag"
  end

  def holiday(%Date{month: 5, day: 4}) do
    "Dodenherdenking"
  end

  def holiday(%Date{month: 5, day: 5}) do
    "Bevrijdingsdag"
  end

  def holiday(%Date{month: 12, day: 5}) do
    "Sinterklaas"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Kerstmis"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "Kerstmis"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -2) == date -> "Goede Vrijdag"
      Date.add(easter_date, 0) == date -> "Pasen"
      Date.add(easter_date, 1) == date -> "Pasen"
      Date.add(easter_date, 39) == date -> "Hemelvaartsdag"
      Date.add(easter_date, 49) == date -> "Pinksteren"
      Date.add(easter_date, 50) == date -> "Pinksteren"
      true -> nil
    end
  end
end