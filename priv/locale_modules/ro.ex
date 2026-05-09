defmodule HolidayEx.RO do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Anul nou"
  end

  def holiday(%Date{month: 1, day: 2}) do
    "Anul nou"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Ziua muncii"
  end

  def holiday(%Date{month: 8, day: 15}) do
    "Adormirea Maicii Domnului"
  end

  def holiday(%Date{month: 11, day: 30}) do
    "Sfântul Apostol Andrei"
  end

  def holiday(%Date{month: 12, day: 1}) do
    "Ziua Națională"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Sărbătoarea Nașterii Domnului"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "Sărbătoarea Nașterii Domnului"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      true -> nil
    end
  end
end