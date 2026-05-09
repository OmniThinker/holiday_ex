defmodule HolidayEx.CR do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Año Nuevo"
  end

  def holiday(%Date{month: 4, day: 11}) do
    "Día de Juan Santamaría"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Día del Trabajador"
  end

  def holiday(%Date{month: 7, day: 25}) do
    "Día de la Anexión de Guanacaste"
  end

  def holiday(%Date{month: 8, day: 2}) do
    "Día de la Virgen de los Angeles"
  end

  def holiday(%Date{month: 8, day: 15}) do
    "Día de la Madre"
  end

  def holiday(%Date{month: 9, day: 15}) do
    "Día de la Independencia"
  end

  def holiday(%Date{month: 10, day: 12}) do
    "Día de las Culturas"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Navidad"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -3) == date -> "Jueves Santo"
      Date.add(easter_date, -2) == date -> "Viernes Santo"
      true -> nil
    end
  end
end