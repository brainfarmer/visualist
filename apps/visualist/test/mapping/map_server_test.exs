defmodule Mapping.MapServerTest do
  use ExUnit.Case, async: true

  @test_id "test_id"
  
  setup context do
    {:ok, map_server}= Mapping.MapServer.start_link(@test_id, 123, "ABC")
    {:ok, map_server: map_server}
  end
  
    
  test "MapServer registers itself in the Mapping.Registry" do
    assert [{pid, value}] = Registry.lookup(Mapping.Registry, @test_id)
    assert server = Registry.lookup(Mapping.Registry, @test_id)
  end

  
end
