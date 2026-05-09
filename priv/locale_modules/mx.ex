defmodule HolidayEx.MX do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Año nuevo"
  end

  def holiday(%Date{month: 1, day: 6}) do
    "Dia de los Santos Reyes"
  end

  def holiday(%Date{month: 4, day: 30}) do
    "Día del Niño"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Día del Trabajo"
  end

  def holiday(%Date{month: 5, day: 5}) do
    "Cinco de Mayo"
  end

  def holiday(%Date{month: 5, day: 5}) do
    "La Batalla de Puebla"
  end

  def holiday(%Date{month: 5, day: 10}) do
    "Día de la Madre"
  end

  def holiday(%Date{month: 5, day: 15}) do
    "Día del Maestro"
  end

  def holiday(%Date{month: 9, day: 15}) do
    "Grito de Dolores"
  end

  def holiday(%Date{month: 9, day: 16}) do
    "Día de la Independencia"
  end

  def holiday(%Date{month: 10, day: 12}) do
    "Día de la Raza"
  end

  def holiday(%Date{month: 11, day: 1}) do
    "Todos los Santos"
  end

  def holiday(%Date{month: 11, day: 2}) do
    "Los Fieles Difuntos"
  end

  def holiday(%Date{month: 12, day: 12}) do
    "Día de la Virgen de Guadalupe"
  end

  def holiday(%Date{month: 12, day: 24}) do
    "Nochebuena"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Navidad"
  end

  def holiday(%Date{month: 12, day: 28}) do
    "Los Santos Inocentes"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      date == HolidayEx.Utils.weekday_to_date(year, 2, 1, 1) -> "Día de la Constitución"
      date == HolidayEx.Utils.weekday_to_date(year, 3, 3, 1) -> "Natalicio de Benito Juárez"
      date == HolidayEx.Utils.weekday_to_date(year, 6, 3, 0) -> "Día del Padre"
      date == HolidayEx.Utils.weekday_to_date(year, 11, 3, 1) -> "Día de la Revolución"
      true -> nil
    end
  end
end