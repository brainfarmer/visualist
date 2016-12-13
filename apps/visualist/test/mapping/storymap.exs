defmodule StoryMap.ListTest do
  use ExUnit.Case, async: true
  end

  test "add single card to cell" do
    expected_card = [
      %Card{title: "a", desc: "desc", link: "---"} ]

    cell = MapCell.add_card(%MapCell{}, expected_card)
    assert cell.cards == expected_card
  end
  
end
