defmodule HolidayEx.CL do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Año Nuevo"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Día del Trabajo"
  end

  def holiday(%Date{month: 5, day: 21}) do
    "Día de las Glorias Navales"
  end

  def holiday(%Date{month: 6, day: 29}) do
    "San Pedro y San Pablo"
  end

  def holiday(%Date{month: 7, day: 16}) do
    "Día de la Virgen del Carmen"
  end

  def holiday(%Date{month: 8, day: 15}) do
    "Asunción de la Virgen"
  end

  def holiday(%Date{month: 9, day: 18}) do
    "Independencia Nacional"
  end

  def holiday(%Date{month: 9, day: 19}) do
    "Día de las Glorias del Ejército"
  end

  def holiday(%Date{month: 10, day: 12}) do
    "Encuentro de Dos Mundos"
  end

  def holiday(%Date{month: 10, day: 31}) do
    "Día de las Iglesias Evangélicas y Protestantes"
  end

  def holiday(%Date{month: 11, day: 1}) do
    "Día de Todos los Santos"
  end

  def holiday(%Date{month: 12, day: 8}) do
    "Inmaculada Concepción de María"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Navidad"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -2) == date -> "Viernes Santo"
      Date.add(easter_date, -1) == date -> "Sábado Santo"
      true -> nil
    end
  end
end