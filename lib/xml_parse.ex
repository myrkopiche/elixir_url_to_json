defmodule XmlParse do
  @moduledoc """
  Documentation for XmlParse.
  """

  @doc """
  Hello world.

  ## Examples

      iex> XmlParse.hello
      :world

  """
  def fetchXml() do
    #{:ok, resp} = :httpc.request(:get, {url, []}, [], [body_format: :binary])
    Response = :httpc.request(:get, {'http://playerservices.streamtheworld.com/api/livestream?station=TRITONRADIOMUSIC&transports=http%2Chls%2Chlsts&version=1.9', []}, [], [])
    IO.puts(Response)
    {:ok, "asdg"}
    # {{_, 200, 'OK'}, _headers, body} = resp
    # File.write!("/tmp/xml_tmp.xml", body)

  end
end
