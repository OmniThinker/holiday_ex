defmodule HolidayEx.AU do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "New Year's Day"
  end

  def holiday(%Date{month: 1, day: 26}) do
    "Australia Day"
  end

  def holiday(%Date{month: 4, day: 25}) do
    "ANZAC Day"
  end

  def holiday(%Date{month: 4, day: 25}) do
    "ANZAC Day"
  end

  def holiday(%Date{month: 4, day: 25}) do
    "ANZAC Day"
  end

  def holiday(%Date{month: 6, day: 6}) do
    "Queensland Day"
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
      Date.add(easter_date, 0) == date -> "Easter Sunday"
      Date.add(easter_date, 1) == date -> "Easter Monday"
      date == HolidayEx.Utils.weekday_to_date(year, 2, 2, 1) -> "Royal Hobart Regatta"
      date == HolidayEx.Utils.weekday_to_date(year, 3, 1, 1) -> "Labour Day"
      date == HolidayEx.Utils.weekday_to_date(year, 3, 2, 1) -> "Eight Hours Day"
      date == HolidayEx.Utils.weekday_to_date(year, 3, 2, 1) -> "Labour Day"
      date == HolidayEx.Utils.weekday_to_date(year, 5, 1, 1) -> "May Day"
      date == HolidayEx.Utils.weekday_to_date(year, 6, 1, 1) -> "Foundation Day"
      date == HolidayEx.Utils.weekday_to_date(year, 6, 2, 1) -> "Queen's Birthday"
      date == HolidayEx.Utils.weekday_to_date(year, 7, 3, 5) -> "Cairns Show"
      date == HolidayEx.Utils.weekday_to_date(year, 8, -3, 3) -> "Ekka"
      date == HolidayEx.Utils.weekday_to_date(year, 9, -1, 1) -> "Queen's Birthday"
      date == HolidayEx.Utils.weekday_to_date(year, 9, -1, 1) -> "Family & Community Day"
      date == HolidayEx.Utils.weekday_to_date(year, 10, 1, 1) -> "Labour Day"
      date == HolidayEx.Utils.weekday_to_date(year, 11, 1, 1) -> "Recreation Day"
      date == HolidayEx.Utils.weekday_to_date(year, 11, 1, 2) -> "Melbourne Cup Day"
      march_pub_hol_sa(year) -> "March Public Holiday"
      qld_labour_day_may(year) -> "Labour Day"
      may_pub_hol_sa(year) -> "May Public Holiday"
      afl_grand_final(year) -> "Friday before the AFL Grand Final"
      qld_labour_day_october(year) -> "Labour Day"
      qld_queens_bday_october(year) -> "Queen's Birthday"
      hobart_show_day(year) -> "Royal Hobart Show"
      g20_day_2014_only(year) -> "G20 Day"
      to_weekday_if_boxing_weekend_from_year(year) -> "Boxing Day"
      true -> nil
    end
  end
enddef self.afl_grand_final(year)
  if year == 2015
    Date.civil(2015, 10, 2)
  end
end    
# http://www.justice.qld.gov.au/fair-and-safe-work/industrial-relations/public-holidays/dates
# G20 day in brisbane, in 2014, on november 14
def self.g20_day_2014_only(year)
  year == 2014 ? 14 : nil
end
# http://worksafe.tas.gov.au/__data/assets/pdf_file/0008/287036/Public_Holidays_2014.pdf
# The Thursday before the fourth Saturday in October. 
def self.hobart_show_day(year)
  fourth_sat_in_oct = Date.civil(year, 10, Holidays.calculate_day_of_month(year, 10, 4, :saturday))
  fourth_sat_in_oct - 2 # the thursday before
end
# http://www.safework.sa.gov.au/show_page.jsp?id=2483#.VQ9Mfmb8-8E
# The Holidays Act 1910 provides for the third Monday in May to be a public holiday. Since 2006 this public holiday has been observed on the second Monday in March through the issuing of a special Proclamation by the Governor.
def self.march_pub_hol_sa(year)
  if year < 2006
    nil
  else
    Date.civil(year, 3, Date.calculate_mday(year, 3, :second, :monday))
  end
end
# http://www.safework.sa.gov.au/show_page.jsp?id=2483#.VQ9Mfmb8-8E
# The Holidays Act 1910 provides for the third Monday in May to be a public holiday. Since 2006 this public holiday has been observed on the second Monday in March through the issuing of a special Proclamation by the Governor.
def self.may_pub_hol_sa(year)
  if year >= 2006
    nil
  else
    Date.civil(year, 5, Date.calculate_mday(year, 5, :third, :monday))
  end
end
# http://www.justice.qld.gov.au/fair-and-safe-work/industrial-relations/public-holidays/dates
# changed from may to october after 2012
def self.qld_labour_day_may(year)
  year <= 2012 ? Holidays.calculate_day_of_month(year, 5, 1, 1) : nil
end
# http://www.justice.qld.gov.au/fair-and-safe-work/industrial-relations/public-holidays/dates
# changed from may to october after 2012
def self.qld_labour_day_october(year)
  year <= 2012 ? nil : Holidays.calculate_day_of_month(year, 10, 1, 1)
end
# http://www.justice.qld.gov.au/fair-and-safe-work/industrial-relations/public-holidays/dates
# celebrated twice in 2012
def self.qld_queens_bday_october(year)
  year == 2012 ? 1 : nil
end
