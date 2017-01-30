defmodule Mapping.MapsSupervisorTest do
  use ExUnit.Case, async: true

  setup context do
    opts = [name: context.test, child_prefix: context.test]
    {:ok, sup} = Mapping.MapsSupervisor.start_link(opts)
    {:ok, sup: sup}
  end


  test "Dynamically starts .MapSupervisor child", %{sup: sup} do
    {:ok, pid} = Mapping.MapsSupervisor.start_map_server(sup,  "test_map", 1, "token")
  end


end

