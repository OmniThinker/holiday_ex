defmodule HolidayEx.SG do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "New Year's Day"
  end

  def holiday(%Date{month: 2, day: 14}) do
    "Valentine's Day"
  end

  def holiday(%Date{month: 2, day: 15}) do
    "Total Defence Day"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Labour Day"
  end

  def holiday(%Date{month: 8, day: 9}) do
    "National Day"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Christmas Day"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -2) == date -> "Good Friday"
      true -> nil
    end
  end
end