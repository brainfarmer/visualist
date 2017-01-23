defmodule Mapping.Users.UserSupervisorTest do
  use ExUnit.Case, async: true

  @api_token "abc123"
  
  setup do
    {:ok, pid} = Mapping.Users.UserSupervisor.start_link()
    {:ok, sup_pid: pid}
  end


  test "creates new user" do
   assert {:ok, user_pid} = Mapping.Users.UserSupervisor.new_user(@api_token)
   assert Mapping.Users.User.get_token(user_pid) == @api_token
  end

end

  
