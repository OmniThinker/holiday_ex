defmodule HolidayEx.IS do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Nýársdagur"
  end

  def holiday(%Date{month: 1, day: 6}) do
    "Þrettándinn"
  end

  def holiday(%Date{month: 1, day: 19}) do
    "Bóndadagur"
  end

  def holiday(%Date{month: 2, day: 18}) do
    "Konudagur"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Verkalýðsdagurinn"
  end

  def holiday(%Date{month: 5, day: 13}) do
    "Mæðradagurinn"
  end

  def holiday(%Date{month: 6, day: 3}) do
    "Sjómannadagurinn"
  end

  def holiday(%Date{month: 6, day: 17}) do
    "Lýðveldisdagurinn"
  end

  def holiday(%Date{month: 11, day: 16}) do
    "Dagur íslenskrar tungu"
  end

  def holiday(%Date{month: 12, day: 24}) do
    "Jól"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Jól"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "Jól"
  end

  def holiday(%Date{month: 12, day: 31}) do
    "Gamlárskvöld"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -48) == date -> "Bolludagur"
      Date.add(easter_date, -47) == date -> "Sprengidagur"
      Date.add(easter_date, -46) == date -> "Öskudagur"
      Date.add(easter_date, -7) == date -> "Pálmasunnudagur"
      Date.add(easter_date, -3) == date -> "Skírdagur"
      Date.add(easter_date, -2) == date -> "Föstudaginn langi"
      Date.add(easter_date, 0) == date -> "Páskadagur"
      Date.add(easter_date, 1) == date -> "Annar í páskum"
      Date.add(easter_date, 39) == date -> "Uppstigningardagur"
      Date.add(easter_date, 49) == date -> "Hvítasunnudagur"
      Date.add(easter_date, 50) == date -> "Annar í hvítasunnu"
      date == HolidayEx.Utils.weekday_to_date(year, 8, 1, 1) -> "Frídagur verslunarmanna"
      is_sumardagurinn_fyrsti(year) -> "Sumardagurinn fyrsti"
      true -> nil
    end
  end
end# Iceland: first day of summer (Thursday after 18 April)
def self.is_sumardagurinn_fyrsti(year)
  date = Date.civil(year,4,18)
  if date.wday < 4
    date += (4 - date.wday)
  else date
    date += (11 - date.wday)
  end
  date
end
