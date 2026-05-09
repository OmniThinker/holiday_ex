defmodule HolidayEx.US do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "New Year's Day"
  end

  def holiday(%Date{month: 3, day: 31}) do
    "Cesar Chavez Day"
  end

  def holiday(%Date{month: 7, day: 4}) do
    "Independence Day"
  end

  def holiday(%Date{month: 11, day: 11}) do
    "Veterans Day"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Christmas Day"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -2) == date -> "Good Friday"
      Date.add(easter_date, 0) == date -> "Easter Sunday"
      date == HolidayEx.Utils.weekday_to_date(year, 1, 3, 1) -> "Martin Luther King, Jr. Day"
      date == HolidayEx.Utils.weekday_to_date(year, 2, 3, 1) -> "Presidents' Day"
      date == HolidayEx.Utils.weekday_to_date(year, 5, -1, 1) -> "Memorial Day"
      date == HolidayEx.Utils.weekday_to_date(year, 9, 1, 1) -> "Labor Day"
      date == HolidayEx.Utils.weekday_to_date(year, 10, 2, 1) -> "Columbus Day"
      date == HolidayEx.Utils.weekday_to_date(year, 11, 4, 4) -> "Thanksgiving"
      us_inauguration_day(year) -> "Inauguration Day"
      day_after_thanksgiving(year) -> "Day after Thanksgiving"
      true -> nil
    end
  end
enddef self.day_after_thanksgiving(year)
  Date.calculate_mday(year, 11, 4, 4) + 1
end
# January 20, every fourth year, following Presidential election
def self.us_inauguration_day(year)
  year % 4 == 1 ? 20 : nil
end
