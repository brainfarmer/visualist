defmodule Mapping.Supervisor do
  use Supervisor

  @name Mapping.Supervisor

  #
  # Start the supervisor
  # options:
  #  :name         - the name to use for the supervisor
  #  :child_prefix - the prefix to assign to the children's names to avoid
  #                  `already started` errors during unit test
  def start_link(opts \\[]) do
    opts = Keyword.put_new(opts, :name, @name)
    IO.puts("Starting #{opts[:name]}")
    Supervisor.start_link(__MODULE__, opts[:child_prefix], name: opts[:name])
  end


  def init(child_prefix) do
    # Prefix children names with name of supervisor to allow for asyn unit testing
    # If not prefixed the child name will not be unique and `server already running`
    #  errors will be encountered when running async unit tests
    children = [
      # Define workkers and child supervisors to be supervised
      # worker(Sequence.Worker, [arg1, arg2, arg3])
      worker(Mapping.Server, [[name: Module.concat(child_prefix, Mapping.Server)]]), 
      supervisor(Mapping.MapsSupervisor,
      	[[name: Module.concat(child_prefix, Mapping.MapsSupervisor)]],
      	restart: :permanent)
    ]

    supervise(children, strategy: :one_for_all)
  end

end
