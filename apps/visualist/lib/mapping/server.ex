defmodule Mapping.Server do
  @moduledoc """
  Server for generating and maintaing a Story Map from backlog data

  ## Examples

  """
  use GenServer

  alias Mapping.StoryMap.SMap

  defmodule State do
    @enforce_key [:project_id, :api_token]
    defstruct [:project_id, :api_token, story_map: %SMap{}]
    @type t :: %State{project_id: integer, api_token: String.t, story_map: SMap.t}
  end

  @name __MODULE__

  #
  # API External interface
  #
  @spec start_link(integer, String.t) :: {:ok, pid}
  def start_link(project_id, api_token, opts \\[]) do
    opts = Keyword.put_new(opts, :name, @name)
    GenServer.start_link(__MODULE__, [project_id, api_token], opts)
  end


  def update_credentials(server, project_id, api_token) do
    GenServer.call(server, {:update_credentials, {project_id, api_token}})
  end

  
  @spec get_state(pid()) :: {:ok, StoryMap.Server.State.t} | :error
  def get_state(server) do
    GenServer.call(server, :get_state)
  end

  @spec get_story_map(pid()) :: {:ok, StoryMap.t} | :error
  def get_story_map(server) do
    GenServer.call(server, :get_story_map)
  end
  

  #
  # GenServer Callbacks
  #
  def init([project_id, api_token]) do
    IO.puts("starting StoryMap.Server")
    initial_state = %State{project_id: project_id, api_token: api_token, story_map: %SMap{}}
    {:ok, initial_state}
  end

  
  def handle_call({:update_credentials, {id, token}}, _from, state) do
    new_state = Map.put(state, :project_id, id)
    new_state = Map.put(new_state, :api_token, token)
    {:reply, :ok, new_state}
  end
  
  
  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end
  
  def handle_call(:get_story_map, _from, story_map_state) do
    {:reply, story_map_state, story_map_state}
  end

  # Handle out-of-band messages, this is optional.
  def handle_info(msg, state) do
    IO.puts("received #{inspect msg}")
    {:noreply, state}
  end
  
end
