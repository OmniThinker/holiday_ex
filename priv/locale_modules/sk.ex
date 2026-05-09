defmodule HolidayEx.SK do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Nový rok"
  end

  def holiday(%Date{month: 1, day: 6}) do
    "Zjavenie Pána (Traja králi)"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Sviatok práce"
  end

  def holiday(%Date{month: 5, day: 8}) do
    "Deň víťazstva nad fašizmom"
  end

  def holiday(%Date{month: 7, day: 5}) do
    "Sviatok svätého Cyrila a svätého Metoda"
  end

  def holiday(%Date{month: 8, day: 29}) do
    "Výročie Slovenského národného povstania"
  end

  def holiday(%Date{month: 9, day: 1}) do
    "Deň Ústavy Slovenskej republiky"
  end

  def holiday(%Date{month: 9, day: 15}) do
    "Sedembolestná Panna Mária"
  end

  def holiday(%Date{month: 11, day: 1}) do
    "Sviatok všetkých svätých"
  end

  def holiday(%Date{month: 11, day: 17}) do
    "Deň boja za slobodu a demokraciu"
  end

  def holiday(%Date{month: 12, day: 24}) do
    "Štedrý deň"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "1. sviatok vianočný"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "2. sviatok vianočný"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, 1) == date -> "Veľkonočný pondelok"
      Date.add(easter_date, -2) == date -> "Veľký piatok"
      true -> nil
    end
  end
end