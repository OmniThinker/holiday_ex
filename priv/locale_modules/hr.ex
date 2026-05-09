defmodule HolidayEx.HR do
  @spec holiday(date :: Date.t()) :: binary()
  def holiday(%Date{month: 1, day: 1}) do
    "Nova godina"
  end

  def holiday(%Date{month: 1, day: 6}) do
    "Sveta tri kralja"
  end

  def holiday(%Date{month: 5, day: 1}) do
    "Međunarodni praznik rada"
  end

  def holiday(%Date{month: 6, day: 22}) do
    "Dan antifašističke borbe"
  end

  def holiday(%Date{month: 6, day: 25}) do
    "Dan državnosti"
  end

  def holiday(%Date{month: 8, day: 5}) do
    "Dan pobjede i domovinske zahvalnosti i dan hrvatskih branitelja"
  end

  def holiday(%Date{month: 8, day: 15}) do
    "Velika Gospa"
  end

  def holiday(%Date{month: 10, day: 8}) do
    "Dan neovisnosti"
  end

  def holiday(%Date{month: 11, day: 1}) do
    "Dan svih svetih"
  end

  def holiday(%Date{month: 12, day: 25}) do
    "Božić"
  end

  def holiday(%Date{month: 12, day: 26}) do
    "Sveti Stjepan"
  end

  def holiday(%Date{year: year} = date) do
    easter_date = HolidayEx.Utils.easter(year)

    cond do
      Date.add(easter_date, 0) == date -> "Uskrs"
      Date.add(easter_date, 1) == date -> "Uskrsni ponedjeljak"
      Date.add(easter_date, 60) == date -> "Tijelovo"
      true -> nil
    end
  end
end