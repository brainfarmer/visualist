# test/integration/tracker_integration_test.exs
# Integration tests for tracker API interaction
#
defmodule TrackerIntegrationTest do
  use ExUnit.Case

  @epics_url "/epics"
  @stories_url "/stories"

  # @visualist_tracker_id "1389518"
  # @ja_api_token 'aa6c95ad3b28fa8520fa75b298a533f4'   # jose's token
  #
  # @test_project_id  @visualist_tracker_id
  # @test_api_token @ja_api_token

  test "GET Epics from tracker" do
    {status, response} = Trackerx.call_get(TrackerInfo.test_api_token(),
      TrackerInfo.test_project_id(), @epics_url)

    assert status == :ok
    # Raw json should contain epic types
    assert String.match?(response.body, ~r/"kind":"epic"/)
  end

	test "GET Stories from tracker" do
		{status, response} = Trackerx.call_get(TrackerInfo.test_api_token(),
      TrackerInfo.test_project_id(), @stories_url)

		assert status == :ok
		assert String.match?(response.body, ~r/"kind":"story"/)
	end
end
