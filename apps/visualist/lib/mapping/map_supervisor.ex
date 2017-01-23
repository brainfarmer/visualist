defmodule Mapping.MapSupervisor do
  use Supervisor


  #
  # API
  #
  def start_link([name, proj_id, api_token]) do
    IO.puts("Starting #{name}")
    sup_name = :"#{name}.MapSupervisor"
    Supervisor.start_link(__MODULE__, [name, proj_id, api_token], name: sup_name)
  end


  #
  # Callbacks
  #
  def init ([name, proj_id, api_token]) do
    task_sup_name = :"#{name}.MapTaskSupervisor"
    server_name = :"#{name}.MapServer"
    map_name = :"#{name}.Storymap"
    children =[
      supervisor(Task.Supervisor, [[name: task_sup_name]]),
      worker(Mapping.StoryMap,[map_name], restart: :transient),
      worker(Mapping.MapServer, [server_name, proj_id, api_token], restart: :transient)
    ]

    supervise(children, strategy: :one_for_all)
  end

end
