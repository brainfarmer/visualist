defmodule Visualist do
  use Application

  # def start(_type, args) do
  #   Visualist.Supervisor.start_link()
  # end
  
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: Visualist.Worker.start_link(arg1, arg2, arg3)
      # worker(Visualist.Worker, [arg1, arg2, arg3]),
      supervisor(Task.Supervisor, [[name: Mapping.TaskSupervisor]]),
      supervisor(Mapping.Supervisor, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: Visualist.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

