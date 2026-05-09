defmodule HolidayEx.GB do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "New Year's Day"
  end

  def holiday(%Date{month: 1, day: 2}) do
    "2nd January"
  end

  def holiday(%Date{month: 3, day: 5}) do
    "St. Piran's Day"
  end

  def holiday(%Date{month: 3, day: 17}) do
    "St. Patrick's Day"
  end

  def holiday(%Date{month: 5, day: 9}) do
    "Liberation Day"
  end

  def holiday(%Date{month: 7, day: 5}) do
    "Tynwald Day"
  end

  def holiday(%Date{month: 7, day: 12}) do
    "Battle of the Boyne"
  end

  def holiday(%Date{month: 11, day: 5}) do
    "Guy Fawkes Day"
  end

  def holiday(%Date{month: 11, day: 30}) do
    "St. Andrew's Day"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Christmas Day"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "Boxing Day"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -2) == date -> "Good Friday"
      Date.add(easter_date, 0) == date -> "Easter Sunday"
      Date.add(easter_date, 1) == date -> "Easter Monday"
      date == HolidayEx.Utils.weekday_to_date(year, 5, 1, 1) -> "May Day"
      date == HolidayEx.Utils.weekday_to_date(year, 5, -1, 1) -> "Bank Holiday"
      date == HolidayEx.Utils.weekday_to_date(year, 8, 1, 1) -> "Bank Holiday"
      date == HolidayEx.Utils.weekday_to_date(year, 8, -1, 1) -> "Bank Holiday"
      true -> nil
    end
  end
end