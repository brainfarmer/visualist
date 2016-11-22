defmodule Tracker.WorkerTest do
  use ExUnit.Case, async: true

  alias Tracker.Worker

  @test_project_id 1389518
  @test_api_token "aa6c95ad3b28fa8520fa75b298a533f4"


#  @tag :skip
  test "retrieves stories & epics" do
    assert {:ok, results} = Worker.get_epics_and_stories(@test_project_id, @test_api_token)
    assert results[:epics]
    assert results[:stories]
  end

#  @tag :skip
  test "retrieve stories" do
    {:ok, results} = Worker.get_stories(@test_project_id, @test_api_token)
    assert results[:stories]
  end

  test "retrieve epics" do
    {:ok, results} = Worker.get_epics(@test_project_id, @test_api_token)
    assert results[:epics]
  end  
  
    
end

