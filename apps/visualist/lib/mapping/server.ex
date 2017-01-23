defmodule Mapping.Server do
  @moduledoc """
  Server inteface for managing the creation of story maps

  ## Examples

  """
  use GenServer

  @name __MODULE__

  #
  # API External interface
  #

  @spec start_link([]) :: {:ok, pid}
  def start_link(opts \\[]) do
    IO.puts("Starting #{opts[:name]}")
    opts = Keyword.put_new(opts, :name, @name)
    GenServer.start_link(__MODULE__, :ok, name: opts[:name])
  end

  
  #
  # GenServer Callbacks
  #

  def init(:ok) do
    {:ok, {}}
  end

end
