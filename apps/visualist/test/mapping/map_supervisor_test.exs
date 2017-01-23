defmodule Mapping.MapSupervisorTest do
  use ExUnit.Case, async: true

  setup context do
    {:ok, sup} = Mapping.MapSupervisor.start_link([context.test, 1, 12])
    {:ok, sup: sup}
  end


  test "Starts .MapServer child", %{sup: sup} do
    child_list = Supervisor.which_children(sup)
    assert List.keymember?(child_list, [Mapping.MapServer], 3) == true
  end

  test "Starts .MapTaskSupervisor child", %{sup: sup} do
    child_list = Supervisor.which_children(sup)
    assert List.keymember?(child_list, [Task.Supervisor], 3) == true
  end


  test "Starts .StoryMap child" , %{sup: sup} do
    child_list = Supervisor.which_children(sup)
    assert List.keymember?(child_list, [Mapping.StoryMap], 3) == true
  end

end

