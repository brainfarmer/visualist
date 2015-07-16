defmodule Trackerx do
  @moduledoc """
  Provides an API wrapper for Tracker.k
  """
  use HTTPoison.Base

  @endpoint "https://www.pivotaltracker.com/services/v5/projects/"

  # override base::process_url to create the tracker url
 def process_url(url) do
  @endpoint <> url
 end

  # override base::process_request_headers to add tracker API token
  # or override the base::send process and set the token as part
  # of the request

  # get the epics for the specified project
  def call_get(api_token, project_id, url) do
    params = ["X-TrackerToken": api_token]

    get(project_id <> url, params)
  end
end
