defmodule Tracker.TaskSupervisor do
  use Supervisor

  @name Tracker.TaskSupervisor

  def start_link(opts \\[]) do
    opt = Keyword.put_new(opts, :name, @name)
    Supervisor.start_child(__MODULE__, :ok, name: opts[:name])
  end


  #
  # Callbacks
  #
  def init(:ok) do
    children = [
      worker(
