defmodule Mapping.Users.User do

  def start_link(api_token) do
    Agent.start_link( fn -> api_token end, [])
  end


  def get_token(user_pid) do
    Agent.get(user_pid, &(&1))
  end


  def stop(user_pid) do
    Agent.stop(user_pid, :normal)
  end
  
  
end
