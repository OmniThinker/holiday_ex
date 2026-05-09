defmodule HolidayEx.VI do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "New Year"
  end

  def holiday(%Date{month: 4, day: 30}) do
    "Liberation Day"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "International Workers' Day"
  end

  def holiday(%Date{month: 9, day: 2}) do
    "National Day"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      true -> nil
    end
  end
end