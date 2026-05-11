defmodule HolidayEx.ZA do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "New Year's Day"
  end

  def holiday(%Date{month: 3, day: 21}) do
    "Human Rights Day"
  end

  def holiday(%Date{month: 4, day: 27}) do
    "Freedom Day"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Workers Day"
  end

  def holiday(%Date{month: 6, day: 16}) do
    "Youth Day"
  end

  def holiday(%Date{month: 8, day: 9}) do
    "National Women's Day"
  end

  def holiday(%Date{month: 9, day: 24}) do
    "Heritage Day"
  end

  def holiday(%Date{month: 12, day: 16}) do
    "Day of Reconciliation"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Christmas Day"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "Day of Goodwill"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -2) == date -> "Good Friday"
      Date.add(easter_date, 1) == date -> "Family Day"
      true -> nil
    end
  end
end

