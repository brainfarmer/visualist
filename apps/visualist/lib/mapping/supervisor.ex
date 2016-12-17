defmodule Mapping.Supervisor do
  use Supervisor

  @name __MODULE__

  def start_link(opts \\[]) do
    opts = Keyword.put_new(opts, :name, @name)
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  
  def start_mapping_worker(supervisor, project_id, api_token) do
    Supervisor.start_child(supervisor, [project_id, api_token])
  end


  def init(:ok) do
    children = [
      # Define workkers and child supervisors to be supervised
      # worker(Sequence.Worker, [arg1, arg2, arg3])
      worker(Mapping.Server, [], restart: :temporary)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
