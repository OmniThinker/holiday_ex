defmodule HolidayEx.JP do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "元日"
  end

  def holiday(%Date{month: 2, day: 11}) do
    "建国記念日"
  end

  def holiday(%Date{month: 4, day: 29}) do
    "昭和の日"
  end

  def holiday(%Date{month: 5, day: 3}) do
    "憲法記念日"
  end

  def holiday(%Date{month: 5, day: 4}) do
    "みどりの日"
  end

  def holiday(%Date{month: 5, day: 5}) do
    "こどもの日"
  end

  def holiday(%Date{month: 11, day: 3}) do
    "文化の日"
  end

  def holiday(%Date{month: 11, day: 23}) do
    "勤労感謝の日"
  end

  def holiday(%Date{month: 12, day: 23}) do
    "天皇誕生日"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      date == HolidayEx.Utils.weekday_to_date(year, 1, 2, 1) -> "成人の日"
      date == HolidayEx.Utils.weekday_to_date(year, 7, 3, 1) -> "海の日"
      date == HolidayEx.Utils.weekday_to_date(year, 9, 3, 1) -> "敬老の日"
      date == HolidayEx.Utils.weekday_to_date(year, 10, 2, 1) -> "体育の日"
      jp_substitute_holiday(year, 1, 1) -> "振替休日"
      jp_substitute_holiday(year, 2, 11) -> "振替休日"
      jp_vernal_equinox_day(year) -> "春分の日"
      jp_substitute_holiday(Holidays.jp_vernal_equinox_day(year)) -> "振替休日"
      jp_substitute_holiday(year, 4, 29) -> "振替休日"
      jp_substitute_holiday(year, 5, 3) -> "振替休日"
      jp_substitute_holiday(year, 5, 4) -> "振替休日"
      jp_substitute_holiday(year, 5, 5) -> "振替休日"
      jp_substitute_holiday(year, 7, Holidays.calculate_day_of_month(year, 7, 3, 1)) -> "振替休日"
      jp_mountain_holiday(year) -> "山の日"
      jp_substitute_holiday(Holidays.jp_mountain_holiday(year)) -> "振替休日"
      jp_substitute_holiday(year, 9, Holidays.calculate_day_of_month(year, 9, 3, 1)) -> "振替休日"
      jp_citizons_holiday(year) -> "国民の休日"
      jp_national_culture_day(year) -> "秋分の日"
      jp_substitute_holiday(Holidays.jp_national_culture_day(year)) -> "振替休日"
      jp_substitute_holiday(year, 10, Holidays.calculate_day_of_month(year, 10, 2, 1)) -> "振替休日"
      jp_substitute_holiday(year, 11, 3) -> "振替休日"
      jp_substitute_holiday(year, 11, 23) -> "振替休日"
      jp_substitute_holiday(year, 12, 23) -> "振替休日"
      true -> nil
    end
  end
enddef self.jp_citizons_holiday(year)
  year < 2003 and return nil
  ncd = Holidays.jp_national_culture_day(year)
  if ncd.wday == 3
    ncd - 1
  else
    nil
  end
end
def self.jp_mountain_holiday(year)
  return nil if year < 2016
  Date.civil(year, 8, 11)
end
def self.jp_national_culture_day(year)
  day =
    case year
    when 1851..1899
      22.2588
    when 1900..1979
      23.2588
    when 1980..2099
      23.2488
    when 2100..2150
      24.2488
    else
      raise IndexError.new("Out of range")
    end
  day += 0.242194 * (year - 1980) - ((year - 1980)/4).floor
  day = day.floor
  Date.civil(year, 9, day)
end
def self.jp_next_weekday(date)
  is_holiday = Holidays::JP.holidays_by_month[date.month].any? do |holiday|
    holiday[:mday] == date.day
  end
  date.wday == 0 || is_holiday ? Holidays.jp_next_weekday(date+1) : date
end
def self.jp_substitute_holiday(*date)
  return nil unless date[0]
  date = date[0].kind_of?(Date) ? date.first : Date.civil(*date)
  date.wday == 0 ? Holidays.jp_next_weekday(date+1) : nil
end
def self.jp_vernal_equinox_day(year)
  day =
    case year
    when 1851..1899
      19.8277
    when 1900..1979
      20.8357
    when 1980..2099
      20.8431
    when 2100..2150
      21.8510
    else
      raise IndexError.new("Out of range")
    end
  day += 0.242194 * (year - 1980) - ((year - 1980)/4).floor
  day = day.floor
  Date.civil(year, 3, day)
end
