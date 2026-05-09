defmodule HolidayEx.FI do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Uudenvuodenpäivä"
  end

  def holiday(%Date{month: 1, day: 6}) do
    "Loppiainen"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Vappu"
  end

  def holiday(%Date{month: 12, day: 6}) do
    "Itsenäisyyspäivä"
  end

  def holiday(%Date{month: 12, day: 24}) do
    "Jouluaatto"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Joulupäivä"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "Tapaninpäivä"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -2) == date -> "Pitkäperjantai"
      Date.add(easter_date, 0) == date -> "Pääsiäispäivä"
      Date.add(easter_date, 1) == date -> "2. Pääsiäispäivä"
      Date.add(easter_date, 39) == date -> "Helatorstai"
      Date.add(easter_date, 49) == date -> "Helluntaipäivä"
      fi_juhannusaatto(year) -> "Juhannusaatto"
      fi_juhannuspaiva(year) -> "Juhannuspäivä"
      true -> nil
    end
  end
end# Finland: Mid-summer eve (Friday between June 19–25)
def self.fi_juhannusaatto(year)
  date = Date.civil(year,6,19)
  if date.wday > 5 #if 19.6 is saturday
    date += 6
  else 
    date += (5 - date.wday)
  end
  date
end
# Finland: Mid-summer (Saturday between June 20–26)
def self.fi_juhannuspaiva(year)
  date = Date.civil(year,6,20)
  date += (6 - date.wday)
  date
end
# Finland: All Saint's Day (Saturday between Oct 31 and Nov 6)
def self.fi_pyhainpaiva(year)
  date = Date.civil(year,10,31)
  date += (6 - date.wday)
  date
end
