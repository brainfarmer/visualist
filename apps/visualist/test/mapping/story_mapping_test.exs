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
    %{"name" => "story 1", "current_state" => "unstarted", "id" => "1",
      "labels" => [%{"kind" => "label", "name" => "label_C"}, %{"name" => "sdaf"}]},
    
    %{"name" => "story 2", "current_state" => "accepted", "id" => "2",
      "labels" => [%{"name" => "label_A"}, %{"name" => "sdaf"}]},

    %{"name" => "story 3", "current_state" => "delivered", "id" => "3",
      "labels" => [%{"name" => "label_C"}, %{"name" => "sdaf"}]},

    %{"name" => "story 4", "current_state" => "finished", "id" => "4",
      "labels" => [%{"name" => "label_C"}, %{"name" => "sdaf"}]},

    %{"name" => "story 5", "current_state" => "started", "id" => "5",
      "labels" => [%{"name" => "label_B"}, %{"name" => "sdaf"}]},

    %{"name" => "story 6", "current_state" => "unstarted", "id" => "6",
      "labels" => [%{"name" => "label_A"}, %{"name" => "sdaf"}]},

    %{"name" => "story 7", "current_state" => "rejected", "id" => "7",
      "labels" => [%{"name" => "label_B"}, %{"name" => "sdaf"}]},

    %{"name" => "story 8", "current_state" => "unstarted", "id" => "8",
      "labels" => [%{"name" => "label_C"}, %{"name" => "sdaf"}]}    
  ]


  @expected_story_map_by_column [
    %{col_label: "label_A", id: "2", name: "story 2", current_state: "accepted"},
    %{col_label: "label_A", id: "6", name: "story 6", current_state: "unstarted"},
    %{col_label: "label_B", id: "5", name: "story 5", current_state: "started"},
    %{col_label: "label_B", id: "7", name: "story 7", current_state: "rejected"},
    %{col_label: "label_C", id: "1", name: "story 1", current_state: "unstarted"},
    %{col_label: "label_C", id: "3", name: "story 3", current_state: "delivered"},
    %{col_label: "label_C", id: "4", name: "story 4", current_state: "finished"},
    %{col_label: "label_C", id: "8", name: "story 8", current_state: "unstarted"}
  ]


  
  
  test "Header map from tracker data" do
    assert StoryMapping.col_headers(@header_data) == @expected_header_map
  end

    
  test "Generates story map by column label" do
    assert StoryMapping.stories_by_column_label(@expected_header_map, @stories) == @expected_story_map_by_column
  end
  



end
