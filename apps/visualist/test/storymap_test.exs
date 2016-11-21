defmodule StoryMap.StoryMapTest do
  use ExUnit.Case, async: true
  doctest StoryMap

  alias StoryMap
  alias StoryMap.HeaderEntry
  alias StoryMap.Card
  alias StoryMap.MapCell
  # @tag :pending
  # test "the truth" do
  #   assert 1 + 1 == 2
  # end

  # test "create new story map" do
  #   assert StoryMap.new() == %StoryMap{}
  # end
  
  test "add column headers from map" do
    expected_headers = [
      %HeaderEntry{position: 1, text: "col_1"},
      %HeaderEntry{position: 2, text: "col_2"},
      %HeaderEntry{position: 3, text: "col_3"} ]

    story_map = StoryMap.add_col_headers(%StoryMap{}, expected_headers)
    assert story_map.col_headers == expected_headers
  end

  
  test "add row headers to map" do
    expected_headers = [
      %HeaderEntry{position: 1, text: "row_1"},
      %HeaderEntry{position: 2, text: "row_2"},
      %HeaderEntry{position: 3, text: "row_3"} ]

    story_map = StoryMap.add_row_headers(%StoryMap{}, expected_headers)
    assert story_map.row_headers == expected_headers
  end

  test "add cells to map" do
    expected_cells = [
      %MapCell{coord: {1, 1}, cards: [
		  %Card{title: "a", desc: "a-desc", link: "---"},
		  %Card{title: "b", desc: "b-desc", link: "b-link"}]},
      %MapCell{coord: {1, 2}, cards: [
		  %Card{title: "c", desc: "c-desc", link: "---"}]}
    ]

    story_map = StoryMap.add_cells(%StoryMap{}, expected_cells)
    assert story_map.cells == expected_cells
  end

  test "add single card to cell" do
    expected_card = [
      %Card{title: "a", desc: "desc", link: "---"} ]

    cell = MapCell.add_card(%MapCell{}, expected_card)
    assert cell.cards == expected_card
  end
  
end
