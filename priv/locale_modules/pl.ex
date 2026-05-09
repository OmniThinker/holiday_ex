defmodule HolidayEx.PL do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Nowy Rok"
  end

  def holiday(%Date{month: 1, day: 21}) do
    "Dzień Babci"
  end

  def holiday(%Date{month: 1, day: 22}) do
    "Dzień Dziadka"
  end

  def holiday(%Date{month: 2, day: 2}) do
    "Ofiarowanie Pańskie (Matki Boskiej Gromnicznej)"
  end

  def holiday(%Date{month: 2, day: 14}) do
    "Dzień Zakochanych (Walentynki)"
  end

  def holiday(%Date{month: 3, day: 8}) do
    "Dzień Kobiet"
  end

  def holiday(%Date{month: 3, day: 10}) do
    "Dzień Mężczyzn"
  end

  def holiday(%Date{month: 4, day: 1}) do
    "Prima Aprilis"
  end

  def holiday(%Date{month: 4, day: 22}) do
    "Międzynarodowy Dzień Ziemi"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Święto Państwowe (Święto Pracy)"
  end

  def holiday(%Date{month: 5, day: 2}) do
    "Dzień Flagi Rzeczpospolitej Polskiej"
  end

  def holiday(%Date{month: 5, day: 3}) do
    "Święto Narodowe Trzeciego Maja"
  end

  def holiday(%Date{month: 6, day: 23}) do
    "Dzień Ojca"
  end

  def holiday(%Date{month: 8, day: 15}) do
    "Wniebowzięcie Najświętszej Maryi Panny"
  end

  def holiday(%Date{month: 8, day: 15}) do
    "Święto Wojska Polskiego"
  end

  def holiday(%Date{month: 9, day: 30}) do
    "Dzień Chłopaka"
  end

  def holiday(%Date{month: 10, day: 14}) do
    "Dzień Nauczyciela (Dzień Edukacji Narodowej)"
  end

  def holiday(%Date{month: 11, day: 1}) do
    "Wszystkich Świętych"
  end

  def holiday(%Date{month: 11, day: 2}) do
    "Dzień Zaduszny"
  end

  def holiday(%Date{month: 11, day: 11}) do
    "Narodowe Święto Niepodległości"
  end

  def holiday(%Date{month: 11, day: 29}) do
    "Andrzejki"
  end

  def holiday(%Date{month: 12, day: 4}) do
    "Barbórka (Dzień Górnika, Naftowca i Gazownika)"
  end

  def holiday(%Date{month: 12, day: 6}) do
    "Mikołajki"
  end

  def holiday(%Date{month: 12, day: 24}) do
    "Wigilia Bożego Narodzenia"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "pierwszy dzień Bożego Narodzenia"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "drugi dzień Bożego Narodzenia"
  end

  def holiday(%Date{month: 12, day: 31}) do
    "Sylwester"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -52) == date ->
        "Tłusty Czwartek"

      Date.add(easter_date, -47) == date ->
        "Ostatki"

      Date.add(easter_date, -46) == date ->
        "Środa Popielcowa"

      Date.add(easter_date, -7) == date ->
        "Niedziela Palmowa"

      Date.add(easter_date, -3) == date ->
        "Wielki Czwartek"

      Date.add(easter_date, -2) == date ->
        "Wielki Piątek"

      Date.add(easter_date, -1) == date ->
        "Wielka Sobota"

      Date.add(easter_date, 0) == date ->
        "Niedziela Wielkanocna"

      Date.add(easter_date, 1) == date ->
        "Poniedziałek Wielkanocny (Lany Poniedziałek)"

      Date.add(easter_date, 49) == date ->
        "Zesłanie Ducha Świętego (Zielone Świątki)"

      Date.add(easter_date, 60) == date ->
        "Uroczystość Najświętszego Ciała i Krwi Pańskiej (Boże Ciało)"

      pl_trzech_kroli(year) ->
        "Objawienie Pańskie (święto Trzech Króli)"

      pl_trzech_kroli_informal(year) ->
        "Objawienie Pańskie (święto Trzech Króli)"

      true ->
        nil
    end
  end
end# Poland: January 6 is holiday since 2011
def self.pl_trzech_kroli(year)
  year >= 2011 ? 6 : nil
end
# Poland: January 6 wasn't holiday before 2011
def self.pl_trzech_kroli_informal(year)
  year < 2011 ? 6 : nil
end
