# test/integration/tracker_integration_test.exs
# Integration tests for tracker API interaction
#
defmodule TrackerIntegrationTest do
  use ExUnit.Case

  @tracker_mapper_tracker_id "1334474"
  @ja_api_token 'aa6c95ad3b28fa8520fa75b298a533f4'  # jose's token

  @test_project_id  @tracker_mapper_tracker_id
  @test_api_token @ja_api_token

  test "GET Epics from tracker" do
    {status, response} = Trackerx.get_epics(@test_project_id, @test_api_token)

    assert status == :ok
    # Raw json should contain epic types
    assert String.match?(response.body, ~r/"kind":"epic"/)
  end
end
