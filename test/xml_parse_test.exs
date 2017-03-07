defmodule XmlParseTest do
  use ExUnit.Case
  doctest XmlParse
  
  require Record
  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText,    Record.extract(:xmlText,    from_lib: "xmerl/include/xmerl.hrl")
  

  test "parsing mountpoints" do
    assert 1+1 == 2
  end

end
