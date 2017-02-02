defmodule Mapping.StoryMapping do

  # from: %{"name" => "value", "label" => %{"name" => "value"}
  # to: %{name: "value", label: "value"}
  def col_headers(backlog_header_data) do
    Enum.map(backlog_header_data, &collapse_to_simple_header(&1))
  end

  
  def stories_by_column_label([], stories, accumulator) do
    accumulator
  end
  
  def stories_by_column_label([header | tail], stories, accumulator \\[]) do
    new_accumulator = accumulator ++ filter_stories_by_header(header, stories)
    stories_by_column_label(tail, stories, new_accumulator)
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

  
  defp filter_stories_by_header(header, stories) do
    Enum.filter(stories, &has_matching_label(&1, header.label))
      |> Enum.map(fn(story) ->
      %{col_label: header.label,
	id: Map.get(story, "id"),
	name: Map.get(story, "name"),
	current_state: Map.get(story, "current_state")
       }
    end)
  end

  
  defp has_matching_label(story, label) do
    Map.get(story, "labels")
    |> Enum.any?(fn(x) -> x ==  %{"name" => label} end)
  end
  

  
  
      
      
		      

    
  
end
