defmodule Mapping.Users.UserSupervisor do
  use Supervisor

  @name __MODULE__

  #
  # API
  #
  def start_link() do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end


  def new_user(api_token) do
    Supervisor.start_child(@name, [api_token])
  end


  #
  # Callbacks
  #
  def init(:ok) do
    children = [
      worker(Mapping.Users.User, [], restart: :temporary)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end



  
end

  
