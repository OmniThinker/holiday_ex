defmodule HolidayEx.EL do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Πρωτοχρονιά"
  end

  def holiday(%Date{month: 1, day: 6}) do
    "Θεοφάνεια"
  end

  def holiday(%Date{month: 3, day: 25}) do
    "Επέτειος της Επανάστασης του 1821"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Πρωτομαγιά"
  end

  def holiday(%Date{month: 8, day: 15}) do
    "Κοίμηση της Θεοτόκου"
  end

  def holiday(%Date{month: 10, day: 28}) do
    "Επέτειος του Όχι"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Χριστούγεννα"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "Δεύτερη ημέρα των Χριστουγέννων"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      true -> nil
    end
  end
end