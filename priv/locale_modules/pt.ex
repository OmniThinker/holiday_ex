defmodule HolidayEx.PT do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Ano Novo"
  end

  def holiday(%Date{month: 4, day: 25}) do
    "Dia da Liberdade"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Dia do Trabalhador"
  end

  def holiday(%Date{month: 6, day: 10}) do
    "Dia de Portugal"
  end

  def holiday(%Date{month: 8, day: 15}) do
    "Assunção de Nossa Senhora"
  end

  def holiday(%Date{month: 12, day: 8}) do
    "Imaculada Conceição"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Natal"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, -47) == date -> "Carnaval"
      Date.add(easter_date, -2) == date -> "Sexta-feira Santa"
      Date.add(easter_date, 0) == date -> "Páscoa"
      true -> nil
    end
  end
end