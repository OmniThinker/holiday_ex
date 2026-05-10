defmodule HolidayEx.PH do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "New Year’s Day"
  end

  def holiday(%Date{month: 2, day: 25}) do
    "People Power Anniversary"
  end

  def holiday(%Date{month: 4, day: 9}) do
    "The Day of Valor"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Labor Day"
  end

  def holiday(%Date{month: 6, day: 12}) do
    "Independence Day"
  end

  def holiday(%Date{month: 8, day: 21}) do
    "Ninoy Aquino Day"
  end

  def holiday(%Date{month: 11, day: 1}) do
    "All Saints Day"
  end

  def holiday(%Date{month: 11, day: 30}) do
    "Bonifacio Day"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Christmas Day"
  end

  def holiday(%Date{month: 12, day: 30}) do
    "Rizal Day"
  end

  def holiday(%Date{month: 12, day: 31}) do
    "New Year's Eve"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -3) == date -> "Maundy Thursday"
      Date.add(easter_date, -2) == date -> "Good Friday"
      Date.add(easter_date, -1) == date -> "Holy Saturday"
      Date.add(easter_date, 0) == date -> "Easter Sunday"
      date == ph_heroes_day(year) -> "National Heroes Day"
      true -> nil
    end
  end

  # last Monday of August
  def ph_heroes_day(year) do
    date = %Date{year: year, month: 8, day: 31}
    weekday = Date.day_of_week(date)

    if weekday == 1 do
      date
    else
      Date.add(date, -(weekday - 1))
    end
  end
end
