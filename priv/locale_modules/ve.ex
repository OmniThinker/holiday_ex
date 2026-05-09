defmodule HolidayEx.VE do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Año Nuevo"
  end

  def holiday(%Date{month: 4, day: 19}) do
    "Declaración Independencia"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Día del Trabajador"
  end

  def holiday(%Date{month: 6, day: 24}) do
    "Aniversario Batalla de Carabobo"
  end

  def holiday(%Date{month: 7, day: 5}) do
    "Día de la Independencia"
  end

  def holiday(%Date{month: 7, day: 24}) do
    "Natalicio de Simón Bolívar"
  end

  def holiday(%Date{month: 10, day: 12}) do
    "Día de la Resistencia Indígena"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Día de Navidad"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -48) == date -> "Lunes Carnaval"
      Date.add(easter_date, -47) == date -> "Martes Carnaval"
      Date.add(easter_date, -3) == date -> "Jueves Santo"
      Date.add(easter_date, -2) == date -> "Viernes Santo"
      true -> nil
    end
  end
end