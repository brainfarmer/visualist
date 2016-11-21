defmodule Tracker.WorkerTest do
  use ExUnit.Case, async: true

  alias Tracker.Worker

  test "always true" do
    assert true
  end

#  @tag :skip
  test "retrieves stories & epics" do
    {:ok, results} = Worker.get_epics_and_stories()
    refute is_nil(results["epics"])
    refute is_nil(results["stories"])
  end
    
end

