defmodule Tracker.WorkerTest do
  use ExUnit.Case, async: true

  alias Tracker.Worker

  @test_project_id 1389518
  @test_api_token "aa6c95ad3b28fa8520fa75b298a533f4"


  #  @tag :skip
  test "retreives epics with GET :epics" do
    assert {:ok, results} = Worker.get(:epics, @test_project_id, @test_api_token)
  end


  test "retrives stories with GET :stories" do
    assert {:ok, results} = Worker.get(:stories, @test_project_id, @test_api_token)
  end
  
  
  test "invalid project_id returns error" do
    assert Worker.get(:epics, 1, @test_api_token) == :error
  end

  
  test "invalid api_token returns error" do
    assert Worker.get(:stories, @test_project_id, "x") == :error
  end

end

