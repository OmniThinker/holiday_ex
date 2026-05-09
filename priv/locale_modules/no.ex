defmodule HolidayEx.NO do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Nyttårsdag"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "1. mai"
  end

  def holiday(%Date{month: 5, day: 17}) do
    "17. mai"
  end

  def holiday(%Date{month: 12, day: 24}) do
    "Julaften"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "1. juledag"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "2. juledag"
  end

  def holiday(%Date{month: 12, day: 31}) do
    "Nyttårsaften"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -49) == date -> "Fastelavn"
      Date.add(easter_date, -7) == date -> "Palmesøndag"
      Date.add(easter_date, -3) == date -> "Skjærtorsdag"
      Date.add(easter_date, -2) == date -> "Langfredag"
      Date.add(easter_date, 0) == date -> "1. påskedag"
      Date.add(easter_date, 1) == date -> "2. påskedag"
      Date.add(easter_date, 39) == date -> "Kristi Himmelfartsdag"
      Date.add(easter_date, 49) == date -> "1. pinsedag"
      Date.add(easter_date, 50) == date -> "2. pinsedag"
      true -> nil
    end
  end
end