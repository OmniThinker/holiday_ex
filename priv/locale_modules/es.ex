defmodule HolidayEx.ES do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Año Nuevo"
  end

  def holiday(%Date{month: 1, day: 6}) do
    "Día de Reyes"
  end

  def holiday(%Date{month: 2, day: 28}) do
    "Día de Andalucía"
  end

  def holiday(%Date{month: 3, day: 1}) do
    "Día de las Islas Baleares"
  end

  def holiday(%Date{month: 3, day: 19}) do
    "San José"
  end

  def holiday(%Date{month: 4, day: 23}) do
    "Día de Castilla y León"
  end

  def holiday(%Date{month: 4, day: 23}) do
    "San Jorge, Día de Aragón"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Día del Trabajador"
  end

  def holiday(%Date{month: 5, day: 2}) do
    "Fiesta de la Comunidad"
  end

  def holiday(%Date{month: 5, day: 30}) do
    "Día de las Canarias"
  end

  def holiday(%Date{month: 5, day: 31}) do
    "Día de la Región Castilla-La Mancha"
  end

  def holiday(%Date{month: 6, day: 9}) do
    "Día de la Región de Murcia"
  end

  def holiday(%Date{month: 6, day: 9}) do
    "Día de La Rioja"
  end

  def holiday(%Date{month: 7, day: 23}) do
    "Santiago Apostol"
  end

  def holiday(%Date{month: 8, day: 15}) do
    "Asunción"
  end

  def holiday(%Date{month: 9, day: 2}) do
    "Día de Ceuta"
  end

  def holiday(%Date{month: 9, day: 8}) do
    "Día de Asturias"
  end

  def holiday(%Date{month: 9, day: 8}) do
    "Día de Extremadura"
  end

  def holiday(%Date{month: 9, day: 11}) do
    "Fiesta Nacional de Cataluña"
  end

  def holiday(%Date{month: 10, day: 9}) do
    "Día de Valencia"
  end

  def holiday(%Date{month: 10, day: 12}) do
    "Día de la Hispanidad"
  end

  def holiday(%Date{month: 11, day: 1}) do
    "Todos los Santos"
  end

  def holiday(%Date{month: 12, day: 6}) do
    "Día de la Constitución"
  end

  def holiday(%Date{month: 12, day: 8}) do
    "Inmaculada Concepción"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Navidad del Señor"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "San Esteban"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -3) == date -> "Jueves Santo"
      Date.add(easter_date, -2) == date -> "Viernes Santo"
      Date.add(easter_date, 1) == date -> "Lunes de Pascua"
      true -> nil
    end
  end
end