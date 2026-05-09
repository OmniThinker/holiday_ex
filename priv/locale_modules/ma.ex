defmodule HolidayEx.MA do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Ras l' âm"
  end

  def holiday(%Date{month: 1, day: 11}) do
    "Takdim watikat al-istiqlal"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Eid Ash-Shughl"
  end

  def holiday(%Date{month: 7, day: 30}) do
    "Eid Al-Ârch"
  end

  def holiday(%Date{month: 8, day: 14}) do
    "Zikra Oued Ed-Dahab"
  end

  def holiday(%Date{month: 8, day: 20}) do
    "Thawrat al malik wa shâab"
  end

  def holiday(%Date{month: 8, day: 21}) do
    "Eid Al Milad"
  end

  def holiday(%Date{month: 11, day: 6}) do
    "Eid Al Massira Al Khadra"
  end

  def holiday(%Date{month: 11, day: 18}) do
    "Eid Al Istiqulal"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      true -> nil
    end
  end
end