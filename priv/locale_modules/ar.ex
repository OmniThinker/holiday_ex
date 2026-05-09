defmodule HolidayEx.AR do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Año Nuevo"
  end

  def holiday(%Date{month: 3, day: 24}) do
    "Día Nacional de la Memoria por la Verdad y la Justicia"
  end

  def holiday(%Date{month: 4, day: 2}) do
    "Día del Veterano y de los Caídos en la Guerra de Malvinas"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Día del Trabajador"
  end

  def holiday(%Date{month: 5, day: 25}) do
    "Día de la Revolución de Mayo"
  end

  def holiday(%Date{month: 6, day: 20}) do
    "Día de la Bandera"
  end

  def holiday(%Date{month: 7, day: 9}) do
    "Día de la Independencia"
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
      Date.add(easter_date, -3) == date ->
        "Jueves Santo"

      Date.add(easter_date, -2) == date ->
        "Viernes Santo"

      date == HolidayEx.Utils.weekday_to_date(year, 8, 3, 1) ->
        "Paso a la Inmortalidad del General José de San Martín"

      date == HolidayEx.Utils.weekday_to_date(year, 10, 2, 1) ->
        "Día del Respeto a la Diversidad Cultural"

      date == HolidayEx.Utils.weekday_to_date(year, 11, 4, 1) ->
        "Día de la Soberanía nacional"

      true ->
        nil
    end
  end
end