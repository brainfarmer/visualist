defmodule Mapping.StoryMapTest do
  use ExUnit.Case, async: true

  alias Mapping.StoryMap
  alias Mapping.StoryMap.SMap
  
  @id 123
  @token "abc"
  @test_map %SMap{}
  
  setup context do
    {:ok, storymap} = StoryMap.start_link(context.test)
    {:ok, storymap: storymap, id: context.test}
  end


  test "StoryMap registers itself in the Mapping.Registry", %{id: id} do
    assert [{pid, value}] = Registry.lookup(Mapping.Registry, id)
  end
  

  test "update project id", %{storymap: storymap} do
    assert :ok = StoryMap.update_project_id(storymap, @id)
    assert StoryMap.get_project_id(storymap) == @id
  end

  
  test "update api tokene", %{storymap: storymap} do
    assert :ok = StoryMap.update_api_token(storymap, @token)
    assert StoryMap.get_api_token(storymap) == @token
  end

  
  test "gets storymap", %{storymap: storymap} do
    assert :ok = StoryMap.update_map(storymap, @test_map)
    assert StoryMap.get_map(storymap) == @test_map
  end


  test "no matching function for update_stormy with simple %{}", %{storymap: storymap} do
    assert_raise(FunctionClauseError, ~r/^no function clause matching/, fn ->
      StoryMap.update_map(storymap, %{}) end)
  end  
end
