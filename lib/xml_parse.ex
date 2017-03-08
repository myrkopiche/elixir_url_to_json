defmodule XmlParse do
  require Record
  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText,    Record.extract(:xmlText,    from_lib: "xmerl/include/xmerl.hrl")

  @moduledoc """
  Documentation for XmlParse.
  """

  @doc """
  Hello world.

  ## Examples

      iex> XmlParse.hello
      :world

  """
  def fetchXml(url) do
    #{:ok, resp} = :httpc.request(:get, {url, []}, [], [body_format: :binary])
    {:ok, resp} = :httpc.request(:get, {String.to_charlist(url), []}, [], [])
    {{_, 200, 'OK'}, _headers, body} = resp
    File.write!("xml_tmp.xml", body)
  end

  def readXml() do
    File.read!("xml_tmp.xml")
    |>:binary.bin_to_list
    |> :xmerl_scan.string
  end

  def parse() do
    {doc,_} = readXml()
    elements = :xmerl_xpath.string('/live_stream_config', doc)
    mountpoints = Enum.map(elements, fn(element) -> 
      _parse(xmlElement(element, :content))
      
    end)
    IO.inspect mountpoints
  end

  def _parse(node) do
    
    cond do
      Record.is_record(node, :xmlElement) ->
        name    = xmlElement(node, :name)
        content = xmlElement(node, :content)
        IO.puts name
        Map.put(%{}, name, _parse(content))

      Record.is_record(node, :xmlText) ->
        xmlText(node, :value) |> to_string

      is_list(node) ->
        case Enum.map(node, &(_parse(&1))) do
          [text_content] when is_binary(text_content) ->
            text_content
          elements ->
            Enum.reduce(elements, %{}, fn(x, acc) ->
              if is_map(x) do
                Map.merge(acc, x)
              else
                acc
              end
            end)
        end

      true -> "Not supported to parse #{inspect node}"
    end
  end



end
