defmodule HolidayEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :holiday_ex,
      version: "0.1.0",
      elixir: "~> 1.19",
      description: "A library for checking publicly observed holidays",
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/yourname/holiday_ex"},
      files: ["lib", "priv", "mix.exs", "README.md", "LICENSE"]
    ]
  end

  defp docs do
    [
      main: "HolidayEx",
      extras: ["README.md"]
    ]
  end

  defp deps do
    [
      {:yaml_elixir, "~> 2.12"},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false}
    ]
  end
end
