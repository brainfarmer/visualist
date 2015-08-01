defmodule Trackerx do
  @moduledoc """
  Provides an API wrapper for Pivotal Tracker
  """
  use HTTPoison.Base

  @endpoint "https://www.pivotaltracker.com/services/v5/projects/"

  # override base::process_url to create the tracker url
  defp process_url(url) do
    @endpoint <> url
  end

  @doc """
  Issue a GET call to the Tracker API with the given endpoint.

  Args:
    * api_token - the Pivotal Tracker user's API token for access
    * project_id - the id of the project the request should be made against
    * url - the endpoint

  Returns:
    {http_status_code, body} - the status code of the Tracker request and the response body
    {:error, reason} - occurs when the Tracker API cannot be reached

  ## Example
    ```
    iex> response = Trackerx.call_get("aa6c95ad3b28fa8520fa75b298a533f4", "1389518", "/epics")
    ```
  """
  # get the epics for the specified project
  @spec call_get(String, String, String) :: {integer | :error, String}
  def call_get(api_token, project_id, url) do
    params = ["X-TrackerToken": api_token]

    request_url(project_id, url)
      |> get(params)
      |> handle_response
  end

  # The http status code is contained in the body of the result tuple
  # extract and use it as the return status
  defp handle_response( {:ok, body} ), do: {body.status_code, body}
  defp handle_response( {:error, reason}), do: {:error, reason}

  defp request_url(project_id, url) do
    "#{project_id}/#{url}"
  end
end
