
defmodule Visualist.HeaderEntry do
  alias Visualist.HeaderEntry

  defstruct [
    position: nil,  # position/order
    text: nil       # header text
  ]
  
  @type t :: %HeaderEntry{position: non_neg_integer, text: String.t}
  
end


defmodule Visualist.Card do
  alias Visualist.Card

  defstruct [
    title: "", # title text
    desc: "",  # descripion
    link: ""   # web link to the card (e.g. Tracker story)
  ]
  
  @type t :: %Card{title: String.t, desc: String.t, link: String.t}

end


defmodule Visualist.MapCell do
  alias Visualist.MapCell
  alias Visualist.Card

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


defmodule Visualist.StoryMap do

  alias Visualist.HeaderEntry
  alias Visualist.Card
  alias Visualist.MapCell
  alias Visualist.StoryMap
  
  defstruct [
    col_headers: [%HeaderEntry{}], # the list of column headers
    row_headers: [%HeaderEntry{}], # the list of row headers
    cells: [%MapCell{}]            # the list of story map cells
  ]
  @type t :: %StoryMap{col_headers: [HeaderEntry.t], row_headers: [HeaderEntry.t],
		       cells: [MapCell.t]}
    

  @spec add_col_headers(StoryMap.t, list(%HeaderEntry{})) :: %StoryMap{}
  def add_col_headers(story_map, entries) do
    put_in(story_map.col_headers, entries)
  end
  
  @spec add_row_headers(%StoryMap{}, list(%HeaderEntry{})) :: %StoryMap{}
  def add_row_headers(story_map, entries) do
    put_in(story_map.row_headers, entries)
  end

  @spec add_cells(%StoryMap{}, list(%MapCell{})) :: %StoryMap{}
  def add_cells(story_map, cell_list) do
    put_in(story_map.cells, cell_list)
  end
  
      
  end
    



