defmodule HolidayEx.DK do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Nytårsdag"
  end

  def holiday(%Date{month: 4, day: 1}) do
    "1. april"
  end

  def holiday(%Date{month: 4, day: 9}) do
    "Danmarks besættelse"
  end

  def holiday(%Date{month: 4, day: 16}) do
    "Dronningens fødselsdag"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Arbejdernes kampdag"
  end

  def holiday(%Date{month: 5, day: 5}) do
    "Danmarks befrielse"
  end

  def holiday(%Date{month: 6, day: 5}) do
    "Grundlovsdag"
  end

  def holiday(%Date{month: 6, day: 15}) do
    "Valdemarsdag og Genforeningsdag"
  end

  def holiday(%Date{month: 6, day: 23}) do
    "Sankt Hans aften"
  end

  def holiday(%Date{month: 11, day: 10}) do
    "Mortensaften"
  end

  def holiday(%Date{month: 12, day: 13}) do
    "Sankt Lucia"
  end

  def holiday(%Date{month: 12, day: 24}) do
    "Juleaftensdag"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "1. juledag"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "2. juledag"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -49) == date -> "Fastelavn"
      Date.add(easter_date, -7) == date -> "Palmesøndag"
      Date.add(easter_date, -3) == date -> "Skærtorsdag"
      Date.add(easter_date, -2) == date -> "Langfredag"
      Date.add(easter_date, 0) == date -> "Påskedag"
      Date.add(easter_date, 1) == date -> "2. påskedag"
      Date.add(easter_date, 26) == date -> "Store Bededag"
      Date.add(easter_date, 39) == date -> "Kristi Himmelfartsdag"
      Date.add(easter_date, 49) == date -> "Pinsedag"
      Date.add(easter_date, 50) == date -> "2. Pinsedag"
      true -> nil
    end
  end
end