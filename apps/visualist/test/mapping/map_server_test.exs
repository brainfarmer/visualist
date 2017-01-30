defmodule Mapping.MapServerTest do
  use ExUnit.Case, async: true

  
  test "MapServer registers itself in the Mapping.Registry" do
    id = 123
    assert {:ok, _} = Mapping.MapServer.start_link(id, 123, "ABC")
    assert [{pid, value}] = Registry.lookup(Mapping.Registry, id)
  end

end
