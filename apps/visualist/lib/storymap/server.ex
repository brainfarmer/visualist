defmodule StoryMap.Server do
  use GenServer

  alias StoryMap

  @name __MODULE__

  # External interface
  def start_link(opts \\[]) do
    opts = Keyword.put_new(opts, :name, @name)
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def add_col_headers(storymap_server, col_headers) do
    GenServer.cast(storymap_server, {:add_col_headers, col_headers})
  end

  def get_story_map(storymap_server) do
    GenServer.call(storymap_server, :get_story_map)
  end
  
  


  # GenServer Callbacks
  def init(args) do
    initial_state = %StoryMap{}
    {:ok, initial_state}
  end
  

  def handle_cast({:add_col_headers, col_headers}, story_map_state) do
    {:noreply, StoryMap.add_col_headers(story_map_state, col_headers)}
  end

  def handle_call(:get_story_map, _from, story_map_state) do
    {:reply, story_map_state, story_map_state}
  end
  
end
