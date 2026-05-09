defmodule HolidayEx.IE do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "New Year's Day"
  end

  def holiday(%Date{month: 3, day: 17}) do
    "St. Patrick's Day"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Christmas Day"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "St. Stephen's Day"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, 1) == date -> "Easter Monday"
      date == HolidayEx.Utils.weekday_to_date(year, 5, 1, 1) -> "May Day"
      date == HolidayEx.Utils.weekday_to_date(year, 6, 1, 1) -> "June Bank Holiday"
      date == HolidayEx.Utils.weekday_to_date(year, 8, 1, 1) -> "August Bank Holiday"
      date == HolidayEx.Utils.weekday_to_date(year, 10, -1, 1) -> "October Bank Holiday"
      true -> nil
    end
  end
end# Ireland - Stephens Day is always the day after christmas day
def self.ie_st_stephens_day(date)
  case date.wday
  when 6, 0 then date + 2
  when 1 then date + 1
  else date
  end
end
