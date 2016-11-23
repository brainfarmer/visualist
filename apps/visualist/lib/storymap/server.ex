defmodule StoryMap.Server do
  @moduledoc """
  Server for generating and maintaing a Story Map from backlog data

  ## Examples

  """
  use GenServer

  alias StoryMap

  defmodule State do
    @enforce_key [:project_id, :api_token]
    defstruct [:project_id, :api_token, story_map: %StoryMap{}]
    @type t :: %State{project_id: integer, api_token: String.t, story_map: StoryMap.t}
  end


  @name __MODULE__

  #
  # API External interface
  #
  @spec start_link(StoryMap.Server.State.t) :: {:ok, pid()}
  def start_link(initial_state, opts \\[]) do
    opts = Keyword.put_new(opts, :name, @name)
    GenServer.start_link(__MODULE__, initial_state, opts)
  end
  

  @spec get_state(pid()) :: {:ok, StoryMap.Server.State.t} | :error
  def get_state(storymap_server) do
    GenServer.call(storymap_server, :get_state)
  end

  @spec get_story_map(pid()) :: {:ok, StoryMap.t} | :error
  def get_story_map(storymap_server) do
    GenServer.call(storymap_server, :get_story_map)
  end
  

  #
  # GenServer Callbacks
  #
  def init(initial_state) do
    {:ok, initial_state}
  end
  

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end
  
  def handle_call(:get_story_map, _from, story_map_state) do
    {:reply, story_map_state, story_map_state}
  end
  
end
