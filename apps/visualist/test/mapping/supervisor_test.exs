defmodule Mapping.SupervisorTest do
  use ExUnit.Case, async: true

#  alias Mapping.Supervisor

  setup context do
    # Use context.test as name to avoid conflict with already started supervisors
    # when tests are running acynchronously
    {:ok, sup} =Mapping.Supervisor.start_link(name: context.test)
    {:ok, sup: sup}
  end

  test "No workers started on supervisor start", %{sup: sup} do
    %{workers: workers} = Supervisor.count_children(sup)
    assert workers == 0
  end
  

  test "Supervisor dynamically creates workers", %{sup: sup} do
    Mapping.Supervisor.start_mapping_worker(sup,1, "x")
    %{workers: workers} = Supervisor.count_children(sup)
    assert workers > 0
  end

end

