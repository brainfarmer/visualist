defmodule Mapping.Server do
  @moduledoc """
  Server inteface for managing the creation of story maps

  ## Examples

  """
  use GenServer

  
  alias Mapping.MapsSupervisor
  alias Mapping.MapServer
  

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


  def get_story_map(server, name, proj_id, api_token) do
    story_map = GenServer.call(server, {:get_story_map, name, proj_id, api_token})
    Supervisor.stop(:"#{name}.MapSupervisor")
    story_map
  end
  

  
  #
  # GenServer Callbacks
  #

  def init(:ok) do
    {:ok, {}}
  end


  def handle_call({:get_story_map, name,  proj_id, api_token}, _from, state) do
    # start map server aggregate
    MapsSupervisor.start_map_server(MapsSupervisor, name, proj_id, api_token)
    [{map_server, _}] = Registry.lookup(Mapping.Registry, name)
    case  Mapping.MapServer.get_story_map(map_server, proj_id, api_token) do
      {:ok, story_map} -> {:reply, {:ok, story_map}, state}
      {:error, message} -> {:reply, {:error, message}, state}
    end
  end
  

end
