defmodule Trackerx do
  @moduledoc """
  Provides an API wrapper for Tracker.k
  """
  use HTTPoison.Base

  @endpoint "https://www.pivotaltracker.com/services/v5"

  # override base::process_url to create the tracker url
# def process_url(url) do
#  @endpoint <> url
# end

  # override base::process_request_headers to add tracker API token
  # or override the base::send process and set the token as part
  # of the request

  # get the epics for the specified project
  def get_epics(project_id, api_token) do
    params = ["X-TrackerToken": api_token]

#   Trackerx.get("/" <> project_id <> "/epics", params)
    Trackerx.get("https://www.pivotaltracker.com/services/v5/projects/1334474/epics",
    params)


    # make the API call to  Tracker
    #    {:ok, ~s("fooshizzle")} # return something just to test
  end
end
