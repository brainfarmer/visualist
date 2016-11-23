defmodule StoryMap.ServerTest do
  use ExUnit.Case, async: true
  
  doctest StoryMap.Server

  alias StoryMap
  alias StoryMap.Server

  @project_id 1389518
  @api_token "aa6c95ad3b28fa8520fa75b298a533f4"
  
  setup do
    {:ok, storymap_server} = Server.start_link(
      %StoryMap.Server.State{project_id: @project_id, api_token: @api_token},
      [name: {:global, __MODULE__}]
    )

    on_exit(fn ->
      send(storymap_server, :stop)
    end)
    
    {:ok, storymap_server: storymap_server}
  end

  test "server is initialized with project_id and api token", context do
    state = Server.get_state(context[:storymap_server])
    assert state.project_id == @project_id
    assert state.api_token == @api_token
  end
  

  test "get current state story map", context do
    default_map = %StoryMap{}
    assert Server.get_story_map(context[:storymap_server]).story_map == default_map
  end

  @tag :pending
  test "set project credentials", context do
  end

  @tag :pending
  test "generate story map", context do
  end
  
end
