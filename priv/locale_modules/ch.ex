defmodule HolidayEx.CH do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Neujahrstag"
  end

  def holiday(%Date{month: 1, day: 2}) do
    "Berchtoldstag"
  end

  def holiday(%Date{month: 1, day: 6}) do
    "Dreikönigstag"
  end

  def holiday(%Date{month: 3, day: 1}) do
    "Instauration de la République"
  end

  def holiday(%Date{month: 3, day: 19}) do
    "Josephstag"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Tag der Arbeit"
  end

  def holiday(%Date{month: 6, day: 23}) do
    "Commémoration du plébiscite jurassien"
  end

  def holiday(%Date{month: 6, day: 29}) do
    "San Pietro e Paolo"
  end

  def holiday(%Date{month: 8, day: 1}) do
    "Bundesfeiertag"
  end

  def holiday(%Date{month: 8, day: 15}) do
    "Mariä Himmelfahrt"
  end

  def holiday(%Date{month: 9, day: 22}) do
    "Mauritiustag"
  end

  def holiday(%Date{month: 9, day: 25}) do
    "Bruderklausenfest"
  end

  def holiday(%Date{month: 11, day: 1}) do
    "Allerheiligen"
  end

  def holiday(%Date{month: 12, day: 8}) do
    "Maria Empfängnis"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Weihnachten"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "Stefanstag"
  end

  def holiday(%Date{month: 12, day: 31}) do
    "Restauration de la République"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -2) == date -> "Karfreitag"
      Date.add(easter_date, 1) == date -> "Ostermontag"
      Date.add(easter_date, 39) == date -> "Auffahrt"
      Date.add(easter_date, 50) == date -> "Pfingstmontag"
      Date.add(easter_date, 60) == date -> "Fronleichnam"
      ch_gl_naefelser_fahrt(year) -> "Näfelser Fahrt"
      true -> nil
    end
  end
end# Thursday after the first Sunday of September
def self.ch_ge_jeune_genevois(year)
  date = Date.civil(year,9,1)
  # Find the first Sunday of September
  until date.wday.eql? 0 do
    date += 1
  end
  # Thursday is four days after Sunday
  date + 4
end
# First Thursday of April. If the first Thursday of April is in the week before easter, then a week later.
def self.ch_gl_naefelser_fahrt(year)
  date = Date.civil(year,4,1)
  # Find the first Thursday of April
  until date.wday.eql? 4 do
    date += 1
  end
  if date.eql?(easter(year)-3)
    date += 7
  end
  date
end
# Monday after the third Sunday of September
def self.ch_vd_lundi_du_jeune_federal(year)
  date = Date.civil(year,9,1)
  # Find the first Sunday of September
  until date.wday.eql? 0 do
    date += 1
  end
  # There are 15 days between the first Sunday
  # and the Monday after the third Sunday
  date + 15
end
