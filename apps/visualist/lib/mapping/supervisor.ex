defmodule Mapping.Supervisor do
  use Supervisor

  @name Mapping.Supervisor

  def start_link(opts \\[]) do
    opts = Keyword.put_new(opts, :name, @name)
    Supervisor.start_link(__MODULE__, :ok, name: opts[:name])
  end


  # def start_mapping_worker(name, project_id, api_token) do
  #   Supervisor.start_child(@name, [name: name, project_id, api_token])
  # end
  
  def start_mapping_worker(name, project_id, api_token) do
    start_mapping_worker(Mapping.Supervisor, name, project_id, api_token)
  end
  
  def start_mapping_worker(sup, name, project_id, api_token) do
    args = [name: name,
	    project_id: project_id,
	    api_token: api_token
	   ]

    Supervisor.start_child(sup, [args])
  end


  def init(:ok) do
    children = [
      # Define workkers and child supervisors to be supervised
      # worker(Sequence.Worker, [arg1, arg2, arg3])
      worker(Mapping.Server, [], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
