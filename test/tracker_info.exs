defmodule TrackerInfo do
# Centralize Tracker project ids and api tokens to for testing

  @visualist_tracker_id "1389518"
  @ja_api_token 'aa6c95ad3b28fa8520fa75b298a533f4'   # jose's token

  def test_project_id(), do: @visualist_tracker_id
  def test_api_token(), do: @ja_api_token
end
