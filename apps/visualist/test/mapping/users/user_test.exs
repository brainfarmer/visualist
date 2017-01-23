defmodule Mapping.Users.UserTest do
  use ExUnit.Case, async: true

  @token "abc123"

  setup do
    {:ok, user_pid} = Mapping.Users.User.start_link(@token)
    {:ok, user_pid: user_pid}
  end
  
     
  test "start a new use with an api_token", %{user_pid: user_pid} do
    assert Mapping.Users.User.get_token(user_pid) == @token
  end

end
  
