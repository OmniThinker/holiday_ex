defmodule HolidayEx.CA do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "New Year's Day"
  end

  def holiday(%Date{month: 1, day: 2}) do
    "New Year's"
  end

  def holiday(%Date{month: 3, day: 17}) do
    "St. Patrick's Day"
  end

  def holiday(%Date{month: 6, day: 24}) do
    "Discovery Day"
  end

  def holiday(%Date{month: 6, day: 24}) do
    "Fête Nationale"
  end

  def holiday(%Date{month: 6, day: 21}) do
    "National Aboriginal Day"
  end

  def holiday(%Date{month: 7, day: 1}) do
    "Canada Day"
  end

  def holiday(%Date{month: 7, day: 12}) do
    "Orangemen's Day"
  end

  def holiday(%Date{month: 7, day: 9}) do
    "Nunavut Day"
  end

  def holiday(%Date{month: 11, day: 11}) do
    "Remembrance Day"
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
      date == HolidayEx.Utils.weekday_to_date(year, 2, 3, 1) -> "Family Day"
      date == HolidayEx.Utils.weekday_to_date(year, 2, 3, 1) -> "Louis Riel Day"
      date == HolidayEx.Utils.weekday_to_date(year, 2, 3, 1) -> "Nova Scotia Heritage Day"
      date == HolidayEx.Utils.weekday_to_date(year, 2, 3, 1) -> "Islander Day"
      date == HolidayEx.Utils.weekday_to_date(year, 2, 2, 1) -> "BC Family Day"
      date == HolidayEx.Utils.weekday_to_date(year, 8, 1, 1) -> "BC Day"
      date == HolidayEx.Utils.weekday_to_date(year, 8, 1, 1) -> "Saskatchewan Day"
      date == HolidayEx.Utils.weekday_to_date(year, 8, 1, 1) -> "Heritage Day"
      date == HolidayEx.Utils.weekday_to_date(year, 8, 1, 1) -> "Natal Day"
      date == HolidayEx.Utils.weekday_to_date(year, 8, 1, 1) -> "Civic Holiday"
      date == HolidayEx.Utils.weekday_to_date(year, 8, 1, 1) -> "New Brunswick Day"
      date == HolidayEx.Utils.weekday_to_date(year, 8, 3, 1) -> "Discovery Day"
      date == HolidayEx.Utils.weekday_to_date(year, 9, 1, 1) -> "Labour Day"
      date == HolidayEx.Utils.weekday_to_date(year, 10, 2, 1) -> "Thanksgiving"
      ca_victoria_day(year) -> "Victoria Day"
      ca_victoria_day(year) -> "National Patriotes Day"
      true -> nil
    end
  end
end# Monday on or before May 24
def self.ca_victoria_day(year)
  date = Date.civil(year,5,24)
  if date.wday > 1
    date -= (date.wday - 1)
  elsif date.wday == 0
    date -= 6
  end
  date
end
