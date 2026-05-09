defmodule HolidayEx.IT do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Capodanno"
  end

  def holiday(%Date{month: 1, day: 6}) do
    "Epifania"
  end

  def holiday(%Date{month: 4, day: 25}) do
    "Festa della Liberazione"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Festa dei Lavoratori"
  end

  def holiday(%Date{month: 6, day: 2}) do
    "Festa della Repubblica"
  end

  def holiday(%Date{month: 8, day: 15}) do
    "Assunzione"
  end

  def holiday(%Date{month: 11, day: 1}) do
    "Ognissanti"
  end

  def holiday(%Date{month: 12, day: 8}) do
    "Immacolata Concezione"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Natale"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "Santo Stefano"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, 0) == date -> "Pasqua"
      Date.add(easter_date, 1) == date -> "Lunedì dell'Angelo"
      true -> nil
    end
  end
end