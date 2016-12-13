defmodule Visualist.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: Visualist.Supervisor)
  end


  def init(:ok) do
    IO.puts("Starting #{inspect(__MODULE__)}")
    children = [
      supervisor(Mapping.Supervisor, [])
    ]

    supervise(children, strategy: :rest_for_one)
  end
  

end

  
