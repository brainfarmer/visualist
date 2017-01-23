defmodule Mapping.Map.Supervisor do
  use Supervisor

  @name Mapping.Map.Supervisor


  def start_link(opts \\[]) do
    opts = Keyword.put_new(opts, :name, @name)
    Supervisor.start_link(__MODULE__, :ok, name: opts[:name])
  end


  def init(:ok) do
    children = [
      # Define workkers and child supervisors to be supervised
      # worker(Sequence.Worker, [arg1, arg2, arg3])
    ]

    supervise(children, strategy: :one_for_all)
  end
  
      
end
