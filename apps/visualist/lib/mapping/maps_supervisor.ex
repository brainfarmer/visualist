defmodule Mapping.MapsSupervisor do
  use Supervisor

  @name __MODULE__

  #
  # Start the supervisor
  # options:
  #  :name         - the name to use for the supervisor
  #  :child_prefix - the prefix to assign to the children's names to avoid
  #                  `already started` errors during unit test
  def start_link(opts \\[]) do
    IO.puts("Starting #{opts[:name]}")
    opts = Keyword.put_new(opts, :name, @name)
    Supervisor.start_link(__MODULE__, opts[:name], name: opts[:name])
  end


  def start_map_server(sup, name, id, api_token) do
    Supervisor.start_child(sup, [[name, id, api_token]])
  end
  
  
  

  #
  # Callbacks
  #
  def init(child_prefix) do
    children = [
      # Define workkers and child supervisors to be supervised
      # worker(Sequence.Worker, [arg1, arg2, arg3])
      supervisor(Mapping.MapSupervisor, [], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end

end

 
    
      
