# HolidayEx

 HolidayEx is a library for checking whether a date falls within a publicly observed holiday.

  This module is meant as a replacement for the Holiday library written by CoderDenis. A lot of credit goes
  to him and his library which serves as a baseline for this. Instead of
  messing around with genservers and applications we dynamically load locales at compile time, meaning we don't
  waste anyones memory, and the footprint stays as small as possible. 

Uses easter calculation code from [[https://github.com/CoderDennis/holidays]] as well as yaml files with supported locales.


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `holiday_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:holiday_ex, "~> 1.0.0"}
  ]
end
```
    
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
The library can then be used like so:
```elixir
MyApp.Holiday.holiday?(~D[2026-01-01], :no)
=> true

MyApp.Holiday.holiday?(~D[2026-02-01], :no)
=> false

      MyApp.Holiday.holiday_name(~D[2026-12-24], :no)
      "Julaften"

      MyApp.Holiday.holiday_name(~D[2026-02-01], :no)
      nil
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




