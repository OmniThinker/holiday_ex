# HolidayEx

A library for finding publicly observed holidays. I created this library because
I did not like to start an application and genserver to find holidays which was the method used in CoderDennis' library holidays.

Initially I wanted to generate pattern matching code using meta programming, but I settled
on an in-memory map, reflective of the yaml files, to do lookups, which is arguably less performant than pattern matching and codegen.

Uses easter calculation code from [[https://github.com/CoderDennis/holidays]] as well as yaml files with supported locales.

If there is a problem with the output it might be that the yaml files are not updated or simply wrong. 
Should this be the case, please submit a pull request. The same goes for missing locales.


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `holiday_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:holiday_ex, "~> 0.1.0"}
  ]
end
```

## Usage
```elixir
HolidayEx.holiday?(~D[2026-01-01], :no)
=> true

HolidayEx.holiday?(~D[2026-02-01], :no)
=> false
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/holiday_ex>.

