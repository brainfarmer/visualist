defmodule Mapping.StoryMap do

  defmodule HeaderEntry do
    defstruct [
      position: nil,  # position/order
      text: nil       # header text
    ]
    
    @type t :: %HeaderEntry{position: non_neg_integer, text: String.t}
  end
  

  defmodule Card do
    defstruct [
      title: "", # title text
      desc: "",  # descripion
      link: ""   # web link to the card (e.g. Tracker story)
    ]
    
    @type t :: %Card{title: String.t, desc: String.t, link: String.t}
  end


  defmodule MapCell do
    defstruct [
      coord: {nil, nil},  # x, y coordinates of the cell
      cards: [%Card{}]    # the list of card data
    ]
    
    @type t :: %MapCell{coord: {non_neg_integer, non_neg_integer}, cards: [Card.t]}


    @spec add_card(MapCell.t, Card.t) :: MapCell.t
    def add_card(map_cell, card) do
      put_in(map_cell.cards, card)
    end
  end


  defmodule SMap do
    defstruct [
      col_headers: [%HeaderEntry{}], # the list of column headers
      row_headers: [%HeaderEntry{}], # the list of row headers
      cells: [%MapCell{}]            # the list of story map cells
    ]
    @type t :: %SMap{col_headers: [HeaderEntry.t], row_headers: [HeaderEntry.t],
		     cells: [MapCell.t]}
  end
  
    

  def start_link() do
    Agent.start(fn ->
     %{project_id: nil, api_token: nil, storymap: %SMap{}} end)
  end
  

  def update_project_id(storymap, project_id) do
    Agent.update(storymap, &Map.put(&1, :project_id, project_id))
  end

  
  def update_api_token(storymap, token) do
    Agent.update(storymap, &Map.put(&1, :api_token, token))
  end

  
  def update_map(storymap, map= %SMap{}) do
    Agent.update(storymap, &Map.put(&1, :storymap, map))
  end


  def get_project_id(storymap) do
    Agent.get(storymap, &Map.get(&1, :project_id))
  end


  def get_api_token(storymap) do
    Agent.get(storymap, &Map.get(&1, :api_token))
  end
  

  def get_map(storymap) do
    Agent.get(storymap, &Map.get(&1, :storymap))
  end
  
end


    



