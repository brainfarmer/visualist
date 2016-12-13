defmodule StoryMap.Supervisor do
  use Supervisor

  @name __MODULE__

  def start_link(opts \\[]) do
    opts = Keyword.put_new(opts, :name, @name)
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  
  def init(:ok) do
    IO.puts("Starting StoryMap.Supervisor")
    children = [
      # Define workkers and child supervisors to be supervised
      # worker(Sequence.Worker, [arg1, arg2, arg3])
      worker(StoryMap.Server, [StoryMap.Server])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
