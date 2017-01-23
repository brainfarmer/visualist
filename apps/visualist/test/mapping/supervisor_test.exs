defmodule Mapping.SupervisorTest do
  use ExUnit.Case, async: true

#  alias Mapping.Supervisor

   setup context do
    # Use context.test as name to avoid conflict with already started supervisors
    # when tests are running acynchronously
    #
    # Specify the child_prefix option when starting the supervisor to avoid naming
    # conflicst with already started children
    {:ok, sup} = Mapping.Supervisor.start_link(name: context.test, child_prefix: context.test)
    {:ok, sup: sup}
  end

  test "Starts Mapping.Server on init", %{sup: sup} do
    child_list = Supervisor.which_children(sup) # list of tuples {id, pid, type, modules}
    assert List.keymember?(child_list, [Mapping.Server], 3) == true
  end

  test "Start .MapsSupervisor when started", %{sup: sup} do
    child_list = Supervisor.which_children(sup)  # list of tuples {id, pid, type, modules}
    assert List.keymember?(child_list, [Mapping.MapsSupervisor], 3) == true
  end
   
  test "Supervisor dynamically creates map worker supervision tree", %{sup: sup} do
    %{supervisors: sups, workers: workers} = Supervisor.count_children(sup)
    assert sups == 1
    assert workers == 1
  end

end

