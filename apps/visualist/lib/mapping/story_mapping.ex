defmodule Mapping.StoryMapping do

  # from: %{"name" => "value", "label" => %{"name" => "value"}
  # to: %{name: "value", label: "value"}
  def col_headers(backlog_header_data) do
    Enum.map(backlog_header_data, &collapse_to_simple_header(&1))
  end

  
  def story_map_by_column(headers, stories) do
    #filter where story has same label as map
    # Get the header's label to match against
    # Get the list of labels from tthe stories
    # enum the list and match against the epic label
    # if matches, add the map to the column list
    Enum.map(headers, &filter_stories_by_header(&1, stories))
  end

  
  def filter_stories_by_header(header, stories) do
    Enum.filter(stories, &has_matching_label(&1, header.label))
      |> Enum.map(fn(story) ->
      %{name: Map.get(story, "name"),
	current_state: Map.get(story, "current_state")} end)
  end

  
  #
  # Private
  #
  defp collapse_to_simple_header(header_map) do
    title  = Map.get(header_map, "name")
    
    label_map = Map.get(header_map, "label")
    label = Map.get(label_map, "name")

    %{name: title, label: label}
  end


  defp has_matching_label(story, label) do
    Map.get(story, "labels")
    |> Enum.any?(fn(x) -> x ==  %{"name" => label} end)
  end
  

  
  
      
      
		      

    
  
end
