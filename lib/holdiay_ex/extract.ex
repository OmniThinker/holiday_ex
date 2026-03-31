defmodule HolidayEx.Extract do
  @external_resource Path.join(:code.priv_dir(:holiday_ex), "definitions")

  def extract_locales() do
    extract_locale_files()
    |> Enum.map(&extract_locale/1)
    |> Enum.map(&String.to_atom/1)
    |> MapSet.new()
  end

  defp extract_locale_file(<<_::binary-size(2), ".yaml">> = locale_file), do: locale_file

  defp extract_locale_file(_), do: nil

  def extract_locale(<<locale::binary-size(2), ".yaml">>), do: locale

  def extract_locale_files() do
    {:ok, files} = File.ls(@external_resource)

    files
    |> Enum.map(&extract_locale_file/1)
    |> Enum.filter(&is_binary/1)
  end
end
