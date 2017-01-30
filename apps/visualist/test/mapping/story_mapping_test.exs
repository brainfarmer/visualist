defmodule Mapping.StoryMappingTest do
  use ExUnit.Case, async: true

  alias Mapping.StoryMapping

  # given a map of epics, a project_snapshot, and a map of stories
  # Convert map of stories, to current stories, backlog stories, icebox stories
  # Convert current_stories to story_map_by_column

  @header_data [
    %{"name" => "A", "label" => %{"name" => "label_A"}},
    %{"name" => "B", "label" => %{"name" => "label_B"}},
    %{"name" => "C", "label" => %{"name" => "label_C"}}
  ]

  @expected_header_map [
    %{name: "A", label: "label_A"},
    %{name: "B", label: "label_B"},
    %{name: "C", label: "label_C"}
  ]

  @project_snapshot []

  @stories [
    %{"name" => "story 1", "current_state" => "unstarted",
      "labels" => [%{"name" => "label_C"}, %{"name" => "sdaf"}]},
    %{"name" => "story 2", "current_state" => "accepted",
      "labels" => [%{"name" => "label_A"}, %{"name" => "sdaf"}]},
    %{"name" => "story 3", "current_state" => "delivered",
      "labels" => [%{"name" => "label_C"}, %{"name" => "sdaf"}]},
    %{"name" => "story 4", "current_state" => "finished",
      "labels" => [%{"name" => "label_C"}, %{"name" => "sdaf"}]},
    %{"name" => "story 5", "current_state" => "started",
      "labels" => [%{"name" => "label_B"}, %{"name" => "sdaf"}]},
    %{"name" => "story 6", "current_state" => "unstarted",
      "labels" => [%{"name" => "label_A"}, %{"name" => "sdaf"}]},
    %{"name" => "story 7", "current_state" => "rejected",
      "labels" => [%{"name" => "label_B"}, %{"name" => "sdaf"}]},
    %{"name" => "story 8", "current_state" => "unstarted",
      "labels" => [%{"name" => "label_C"}, %{"name" => "sdaf"}]}    
  ]

  @expected_story_map_by_column [
    %{name: "story 2", current_state: "accepted"},
    %{name: "story 6", current_state: "unstarted"},
    %{name: "story 5", current_state: "started"},
    %{name: "story 7", current_state: "rejected"},
    %{name: "story 1", current_state: "unstarted"},
    %{name: "story 3", current_state: "delivered"},
    %{name: "story 4", current_state: "finished"},
    %{name: "story 8", current_state: "unstarted"}
  ]
  

  
  
  test "Header map from tracker data" do
    assert StoryMapping.col_headers(@header_data) == @expected_header_map
  end


  test "filters stories by matching header label" do
    expected_stories = [
      %{name: "story 2", current_state: "accepted"},
      %{name: "story 6", current_state: "unstarted"}
    ]

    header = %{name: "A", label: "label_A"}

    assert StoryMapping.filter_stories_by_header(header, @stories) == expected_stories
  end
  
    
  test "Generates story map by column" do
    assert StoryMapping.story_map_by_column(@expected_header_map, @stories) == @expected_story_map_by_column
  end
  



end
