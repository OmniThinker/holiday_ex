defmodule HolidayExTest do
  use ExUnit.Case
  doctest HolidayEx

  test "holiday? returns true for new years in Norway" do
    assert HolidayEx.holiday?(~D[2026-01-01], :no)
  end

  test "holiday? returns true when 17th of may in Norway" do
    assert HolidayEx.holiday?(~D[2026-05-17], :no)
  end

  test "holiday? returns true for easter in Norway" do
    assert HolidayEx.holiday?(~D[2026-04-02], :no)
  end

  test "holiday? with non-supported locale" do
    assert_raise ArgumentError, fn -> HolidayEx.holiday?(~D[2026-01-01], :bla) end
  end
end
