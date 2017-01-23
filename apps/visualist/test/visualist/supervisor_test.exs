defmodule Visualist.SupervisorTest do
  use ExUnit.Case, async: true

  setup  do
    Application.stop(:visualist)
    :ok = Application.start(:visualist)
  end


  test "Visualist supervisor is started on app start" do
    assert nil != Process.whereis(Visualist.Supervisor)
  end

  test "Mapping Supervisor is started on app start" do
    assert nil != Process.whereis(Mapping.Supervisor)
  end

  # Refatoring supervision tree, removing mapping task supervisor
  # Can delete this test code once refactoring is complete
  test "Mapping.TaskSupervisor is not started on app start" do
    assert nil == Process.whereis(Mapping.TaskSupervisor)
  end
  
end
