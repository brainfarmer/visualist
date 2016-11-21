defmodule StoryMap.ServerTest do
  use ExUnit.Case, async: true
  
  doctest StoryMap.Server

  alias StoryMap
  alias StoryMap.Server
  alias StoryMap.HeaderEntry

  setup do
    {:ok, storymap_server} = Server.start_link(name: {:global, __MODULE__})

    on_exit(fn ->
      send(storymap_server, :stop)
    end)
    
    {:ok, storymap_server: storymap_server}
  end
  

#   test "start server with default story map" do
# #    {:ok, server} = StoryMap.Server.start_link(context.test)
# #    assert :server > 0 
#   end

  test "get current state story map", context do
    default_map = %StoryMap{}
			      
#    StoryMap.Server.start_link(default_map)
    assert Server.get_story_map(context[:storymap_server]) == default_map
  end
  
			      

  test "add headers", context do
    expected_headers = [
    %HeaderEntry{position: 1, text: "col_1"},
    %HeaderEntry{position: 2, text: "col_2"},
    %HeaderEntry{position: 3, text: "col_3"} ]

 #   StoryMap.Server.start_link(%StoryMap{})
    Server.add_col_headers(context[:storymap_server], expected_headers)
    story_map = Server.get_story_map(context[:storymap_server])
    assert story_map.col_headers == expected_headers
  end
  
  

end
