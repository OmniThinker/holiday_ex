defmodule HolidayEx do
  @moduledoc """
  HolidayEx is a library for checking whether a date falls within a publicly observed holiday.

  This module is meant as a replacement for the Holiday library written by CoderDenis. A lot of credit goes
  to him and his library which serves as a baseline for this. Instead of
  messing around with genservers and applications we dynamically load locales at compile time, meaning we don't
  waste anyones memory, and the footprint stays as small as possible. 
    
  # Usage
  To use this module you create your own holiday module with the specific locales you intend to use.
  This dynamically loads the locale modules at compile time so that you don't get any more than you actually need.

  ```elixir
  defmodule MyApp.Holiday do
    use HolidayEx, locales: [:no, :de, :gb]
  end
  ```
  Alternatively you can load all the locales.
  ```elixir
  defmodule MyApp.Holiday do
    use HolidayEx, locales: :all
  end
  ```

  ## Dependency philosophy
  This library has zero dependencies, meaning as long as you understand the code you can be 100% sure that
  this is the only code that will run inside your program.

  ## Extensions/bugs
  This library is in low-maintance mode. If you have a specific locale with some requirements that may or may not exist
  you have three options:
  1. Submit an issue. If the fix or extension is small
  2. Submit a pull request. I highly encourage this.
  3. Fork the repository. I also highly encourage this, since the library is realtively simple and small (essentially just data)

  ## Disclaimer
  Keep in mind that this library is forward looking in time, meaning we provide no guarantees for holidays that may have existed in the past.

  """

  # In reality it needs to be part of the locales list

  @supported_locales :code.priv_dir(:holiday_ex)
                     |> Path.join("locale_modules/*.ex")
                     |> Path.wildcard()
                     |> Enum.map(&(&1 |> Path.basename(".ex") |> String.to_atom()))

  @type locale :: unquote(Enum.reduce(Enum.reverse(@supported_locales), &{:|, [], [&1, &2]}))

  @doc false
  defmacro __using__(opts) do
    user_locales = Keyword.get(opts, :locales)

    locales =
      if user_locales == :all do
        @supported_locales
      else
        Enum.each(user_locales, fn locale ->
          unless locale in @supported_locales do
            raise "Unsupported locale: #{locale}"
          end
        end)

        user_locales
      end

    quote do
      for locale <- unquote(locales) do
        locale_name = Atom.to_string(locale)
        priv = :code.priv_dir(:holiday_ex) |> List.to_string()
        path = Path.join(priv, "locale_modules/#{locale_name}.ex")
        @external_resource path
        Code.compile_file(path)
      end
    end
  end

  @doc """
  The Holiday.holiday? function takes a `date`, and a loaded `locale` as an atom and 
  produces a `boolean` of whether the date is a publicly observed holiday or not.

  (This function raises if the locale is not loaded properly)

  ## Examples

      iex> HolidayEx.holiday?(~D[2026-01-01], :no)
      true

      iex> HolidayEx.holiday?(~D[2026-02-01], :no)
      false
  """
  @spec holiday?(Date.t(), locale()) :: boolean()
  def holiday?(%Date{} = date, locale) when is_atom(locale) do
    not is_nil(holiday_name(date, locale))
  end

  @doc """
  The Holiday.holiday_name function takes a `date`, and a loaded `locale` as an atom and 
  produces a `string` with the holiday name or `nil` if the date is not a holiday .

  (This function raises if the locale is not loaded properly)

  ## Examples

      iex> HolidayEx.holiday_name(~D[2026-12-24], :no)
      "Julaften"

      iex> HolidayEx.holiday_name(~D[2026-02-01], :no)
      nil
  """
  @spec holiday_name(Date.t(), locale()) :: String.t() | nil
  def holiday_name(%Date{} = date, locale) when is_atom(locale) do
    locale_name = locale |> Atom.to_string() |> String.upcase()
    module_name = Module.concat(HolidayEx, locale_name)

    if Code.ensure_loaded?(module_name) do
      module_name.holiday(date)
    else
      raise ~S"""
      You have not loaded this locale. 
      See the documentation on __using__ this module, 
      and see if your locale is supported
      """
    end
  end
end
