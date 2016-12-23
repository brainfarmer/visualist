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

  test "Mapping.TaskSupervisor is started on app start" do
    assert nil != Process.whereis(Mapping.TaskSupervisor)
  end
  
end
