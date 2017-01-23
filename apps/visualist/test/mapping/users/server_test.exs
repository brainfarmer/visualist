defmodule Mapping.Users.ServerTest do
  use ExUnit.Case, async: true

  @name "joe"
  @token "abc123"

  setup do
    {:ok, _sup} = Mapping.Users.UserSupervisor.start_link()
    {:ok, pid} = Mapping.Users.Server.start_link()
    {:ok, server_pid: pid}
  end
  

  test "adds new user" do
    assert Mapping.Users.Server.lookup(@name) == :error
    assert {:ok, _pid} = Mapping.Users.Server.add(@name, @token)
    assert {:ok, _} = Mapping.Users.Server.lookup(@name)
  end


  test "removes user" do
    :error = Mapping.Users.Server.lookup(@name)
    Mapping.Users.Server.add(@name, @token)
    {:ok, _} = Mapping.Users.Server.lookup(@name)

    assert :ok = Mapping.Users.Server.remove(@name)
    assert :error = Mapping.Users.Server.lookup(@name)
  end


  test "removes monitored user refs on crash" do
    Mapping.Users.Server.add(@name, @token)
    {:ok, pid} = Mapping.Users.Server.lookup(@name)

    Agent.stop(pid, :shutdown)

    # Do an sync call to make sure User.Server processed :DOWN crash msg
    _ = Mapping.Users.Server.add("bogus", "xyz")
    assert Mapping.Users.Server.lookup(@name) == :error
    
  end
  
  
end
