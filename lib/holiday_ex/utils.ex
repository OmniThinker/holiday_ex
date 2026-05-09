defmodule HolidayEx.Utils do
  @moduledoc false

  def easter(year) do
    y = year
    a = rem(y, 19)
    b = div(y, 100)
    c = rem(y, 100)
    d = div(b, 4)
    e = rem(b, 4)
    f = (b + 8) |> div(25)
    g = (b - f + 1) |> div(3)
    h = (19 * a + b - d - g + 15) |> rem(30)
    i = div(c, 4)
    k = rem(c, 4)
    l = (32 + 2 * e + 2 * i - h - k) |> rem(7)
    m = (a + 11 * h + 22 * l) |> div(451)

    month = (h + l - 7 * m + 114) |> div(31)
    day = ((h + l - 7 * m + 114) |> rem(31)) + 1

    Date.new!(year, month, day)
  end
end
