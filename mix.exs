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
      docs: docs(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  defp elixirc_paths(:dev), do: ["lib", "lib/mix/tasks"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/OmniThinker/holiday_ex"},
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
      {:yaml_elixir, "~> 2.12", only: :dev, runtime: false},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false}
    ]
  end
end
