defmodule HolidayEx.CZ do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Den obnovy samostatného českého státu"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Svátek práce"
  end

  def holiday(%Date{month: 5, day: 8}) do
    "Den vítězství"
  end

  def holiday(%Date{month: 7, day: 5}) do
    "Den slovanských věrozvěstů Cyrila a Metoděje"
  end

  def holiday(%Date{month: 7, day: 6}) do
    "Den upálení mistra Jana Husa"
  end

  def holiday(%Date{month: 9, day: 28}) do
    "Den české státnosti"
  end

  def holiday(%Date{month: 10, day: 28}) do
    "Den vzniku samostatného československého státu"
  end

  def holiday(%Date{month: 11, day: 17}) do
    "Den boje za svobodu a demokracii"
  end

  def holiday(%Date{month: 12, day: 24}) do
    "Štědrý den"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "1. svátek vánoční"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "2. svátek vánoční"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, 1) == date -> "Velikonoční pondělí"
      true -> nil
    end
  end
end