defmodule HolidayEx.BG do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "New Year's Day"
  end

  def holiday(%Date{month: 1, day: 1}) do
    "Нова година"
  end

  def holiday(%Date{month: 3, day: 3}) do
    "Liberation Day"
  end

  def holiday(%Date{month: 3, day: 3}) do
    "Освобожението на България"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Labour Day"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Ден на труда"
  end

  def holiday(%Date{month: 5, day: 6}) do
    "St. George's Day"
  end

  def holiday(%Date{month: 5, day: 6}) do
    "Гергьовден. Ден на храбростта"
  end

  def holiday(%Date{month: 5, day: 24}) do
    "Slavic Literacy Day"
  end

  def holiday(%Date{month: 5, day: 24}) do
    "Ден на славянската писменост"
  end

  def holiday(%Date{month: 9, day: 6}) do
    "Unification Day"
  end

  def holiday(%Date{month: 9, day: 6}) do
    "Ден на Съединението"
  end

  def holiday(%Date{month: 9, day: 22}) do
    "The Independence Day"
  end

  def holiday(%Date{month: 9, day: 22}) do
    "Ден на Независимостта"
  end

  def holiday(%Date{month: 11, day: 1}) do
    "Revival Leader's Day"
  end

  def holiday(%Date{month: 11, day: 1}) do
    "Ден на Народните будители"
  end

  def holiday(%Date{month: 12, day: 24}) do
    "Christmas Eve"
  end

  def holiday(%Date{month: 12, day: 24}) do
    "Бъдни вечер"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Christmas"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Рождество Христово. Коледа"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "Christmas"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "Рождество Христово. Коледа"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      true -> nil
    end
  end
end