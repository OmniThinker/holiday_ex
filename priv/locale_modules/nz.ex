defmodule HolidayEx.NZ do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "New Year's Day"
  end

  def holiday(%Date{month: 1, day: 2}) do
    "Day after New Year's Day"
  end

  def holiday(%Date{month: 1, day: 17}) do
    "Southland Anniversary Day"
  end

  def holiday(%Date{month: 1, day: 22}) do
    "Wellington Anniversary Day"
  end

  def holiday(%Date{month: 1, day: 29}) do
    "Auckland Anniversary Day"
  end

  def holiday(%Date{month: 1, day: 29}) do
    "Northland Anniversary Day"
  end

  def holiday(%Date{month: 2, day: 1}) do
    "Nelson Anniversary Day"
  end

  def holiday(%Date{month: 2, day: 6}) do
    "Waitangi Day"
  end

  def holiday(%Date{month: 3, day: 23}) do
    "Otago Anniversary Day"
  end

  def holiday(%Date{month: 4, day: 25}) do
    "ANZAC Day"
  end

  def holiday(%Date{month: 11, day: 30}) do
    "Chatham Island Anniversary Day"
  end

  def holiday(%Date{month: 12, day: 1}) do
    "Westland Anniversary Day"
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
      Date.add(easter_date, -1) == date -> "Easter Saturday"
      Date.add(easter_date, 1) == date -> "Easter Monday"
      date == HolidayEx.Utils.weekday_to_date(year, 3, 2, 1) -> "Taranaki Anniversary Day"
      date == HolidayEx.Utils.weekday_to_date(year, 6, 1, 1) -> "Queen's Birthday"
      date == HolidayEx.Utils.weekday_to_date(year, 9, 4, 1) -> "Dominion Day"
      date == HolidayEx.Utils.weekday_to_date(year, 10, 1, 1) -> "Hawke's bay Anniversary Day"
      date == HolidayEx.Utils.weekday_to_date(year, 10, 4, 1) -> "Labour Day"
      date == HolidayEx.Utils.weekday_to_date(year, 10, 4, 1) -> "Marlborough Anniversary Day"
      date == HolidayEx.Utils.weekday_to_date(year, 11, 2, 5) -> "Canterbury Anniversary Day"
      true -> nil
    end
  end
enddef self.closest_monday(date)
  if [1, 2, 3, 4].include?(date.wday)
    date -= (date.wday - 1)
  elsif 0 == date.wday
    date += 1
  else
    date += 8 - date.wday
  end
  date
end
def self.next_week(date)
  date + 7
end
def self.previous_friday(date)
  date - 3
end
