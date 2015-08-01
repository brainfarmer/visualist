# test/integration/tracker_integration_test.exs
# Integration tests for tracker API interaction
#
defmodule TrackerIntegrationTest do
  use ExUnit.Case

  @epics_url "/epics"
  @stories_url "/stories"

  test "GET Epics from tracker" do
    {status, response} = Trackerx.call_get(TrackerInfo.test_api_token(),
      TrackerInfo.test_project_id(), @epics_url)

    assert status == 200
    assert JSX.is_json?(response.body)
    assert String.match?(response.body, ~r/"kind":"epic"/)
  end

	test "GET Stories from tracker" do
		{status, response} = Trackerx.call_get(TrackerInfo.test_api_token(),
      TrackerInfo.test_project_id(), @stories_url)

		assert status == 200
    assert JSX.is_json?(response.body)
		assert String.match?(response.body, ~r/"kind":"story"/)
	end

  test "GET epics/stories with bad project id returns error" do
    {status, response} = Trackerx.call_get(TrackerInfo.test_api_token(),
      "0", @epics_url)

    assert status > 400
  end
end
