defmodule Mapping.RegistryTest do
  use ExUnit.Case, async: true

  @proj_id 1
  @api_token "ac;lkjasf"

  setup context do
    {:ok, _} = Mapping.Registry.start_link(context.test)
    {:ok, registry: context.test}
  end


  test "spawns mapping servers", %{registry: registry} do
    assert Mapping.Registry.lookup(registry, "test_map") == :error

    Mapping.Registry.create(registry, "test_map", @proj_id, @api_token)
    assert {:ok, _} = Mapping.Registry.lookup(registry, "test_map")
  end

  test "removes mapping servers on exit", %{registry: registry} do
    Mapping.Registry.create(registry, "test_map", @proj_id, @api_token)
    {:ok, mapping_server} = Mapping.Registry.lookup(registry, "test_map")

    GenServer.stop(mapping_server) # Stop server in a normal mode

    # Do a sync call to make sure the registry process the DOWN msg
    _ = Mapping.Registry.create(registry, "crap", @proj_id, @api_token)
    assert Mapping.Registry.lookup(registry, "test_map") == :error
  end


  test "removes mapping servers on crash", %{registry: registry} do
    Mapping.Registry.create(registry, "test_map", @proj_id, @api_token)
    {:ok, mapping_server} = Mapping.Registry.lookup(registry, "test_map")

    GenServer.stop(mapping_server, :shutdown)

    #Do a sync call to make sure registry has processed crash msg
    _ = Mapping.Registry.create(registry, "bogus", @proj_id, @api_token)
    assert Mapping.Registry.lookup(registry, "test_map") == :error
  end
  
  
end

      
