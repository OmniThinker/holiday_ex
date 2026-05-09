defmodule HolidayEx do
  @moduledoc """
  HolidayEx is a library for checking whether a date falls within a publicly observed holiday.

  This module is meant as a replacement for the Holiday library. It builds on that library, but instead of
  messing around with genservers and applications we generate a lookup map using yml files.
  Most of the credit for the actual logic goes to CoderDenis.

  We use  yml files for the holidays, so any discrepancy found in the library can be solved with a pull request 
  adding the relevant data to those files.
  """
  # In reality it needs to be part of the locales list
  @type locale :: atom()

  @doc """
  The Holiday.holiday? function takes a `date`, and a supported `locale` as an atom and 
  produces a `boolean` of whether the date is a publicly observed holiday or not.

  ## Examples

      iex> HolidayEx.holiday?(~D[2026-01-01], :no)
      true

      iex> HolidayEx.holiday?(~D[2026-02-01], :no)
      false
  """
  @spec holiday?(Date.t(), locale()) :: boolean()
  def holiday?(%Date{}, locale) when is_atom(locale) do
    false
  end

  def __using__ do
    # Code.eval_string(File.read!('./priv/locale_modules/no.ex'))
  end
end
