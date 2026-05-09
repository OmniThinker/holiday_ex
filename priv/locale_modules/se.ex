defmodule HolidayEx.SE do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Nyårsdagen"
  end

  def holiday(%Date{month: 1, day: 6}) do
    "Trettondedag jul"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Första maj"
  end

  def holiday(%Date{month: 6, day: 6}) do
    "Nationaldagen"
  end

  def holiday(%Date{month: 12, day: 24}) do
    "Julafton"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Juldagen"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "Annandag jul"
  end

  def holiday(%Date{month: 12, day: 31}) do
    "Nyårsafton"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -2) == date -> "Långfredagen"
      Date.add(easter_date, -1) == date -> "Påskafton"
      Date.add(easter_date, 0) == date -> "Påskdagen"
      Date.add(easter_date, 1) == date -> "Annandag påsk"
      Date.add(easter_date, 39) == date -> "Kristi himmelsfärdsdag"
      Date.add(easter_date, 49) == date -> "Pingstdagen"
      se_midsommardagen(year) -> "Midsommardagen"
      se_midsommardagen(year) - 1 -> "Midsommarafton"
      true -> nil
    end
  end
end# Sweden: All Saint's Day (Saturday between Oct 31 and Nov 6)
def self.se_alla_helgons_dag(year)
  date = Date.civil(year,10,31)
  date += (6 - date.wday)
  date
end
# Sweden: Mid-summer (Saturday between June 20–26)
def self.se_midsommardagen(year)
  date = Date.civil(year,6,20)
  date += (6 - date.wday)
  date
end
