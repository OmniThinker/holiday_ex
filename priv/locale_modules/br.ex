defmodule HolidayEx.BR do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Dia da Confraternização Universal"
  end

  def holiday(%Date{month: 4, day: 21}) do
    "Dia de Tiradentes"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Dia do Trabalho"
  end

  def holiday(%Date{month: 9, day: 7}) do
    "Proclamação da Independência"
  end

  def holiday(%Date{month: 10, day: 12}) do
    "Dia de Nossa Senhora Aparecida"
  end

  def holiday(%Date{month: 11, day: 2}) do
    "Dia de Finados"
  end

  def holiday(%Date{month: 11, day: 15}) do
    "Proclamação da República"
  end

  def holiday(%Date{month: 11, day: 20}) do
    "Dia da Consciência Negra"
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
      Date.add(easter_date, 60) == date -> "Corpus Christi"
      true -> nil
    end
  end
end