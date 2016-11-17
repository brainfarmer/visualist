defmodule StoryMap.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  
  def init(:ok) do
    children = [
      # Define workkers and child supervisors to be supervised
      # worker(Sequence.Worker, [arg1, arg2, arg3])
      worker(StoryMap.Server, [StoryMap.Server])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
