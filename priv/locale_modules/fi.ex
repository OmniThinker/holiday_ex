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
      date == fi_juhannusaatto(year) -> "Juhannusaatto"
      date == fi_juhannuspaiva(year) -> "Juhannuspäivä"
      true -> nil
    end
  end

  # Finland: Mid-summer eve (Friday between June 19–25)
  defp fi_juhannusaatto(year) do
    date = %Date{year: year, month: 6, day: 19}
    weekday = Date.day_of_week(date)
    Date.add(date, rem(5 - weekday + 7, 7))
  end

  # Finland: Mid-summer (Saturday between June 20–26)
  defp fi_juhannuspaiva(year) do
    date = %Date{year: year, month: 6, day: 20}
    weekday = Date.day_of_week(date)
    Date.add(date, rem(6 - weekday + 7, 7))
  end

  defp fi_pyhainpaiva(year) do
    date = %Date{year: year, month: 10, day: 31}
    weekday = Date.day_of_week(date)
    Date.add(date, rem(6 - weekday + 7, 7))
  end
end
