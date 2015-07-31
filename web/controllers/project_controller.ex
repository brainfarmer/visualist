defmodule Visualist.ProjectController do
  use Visualist.Web, :controller

  @api_token Application.get_env(:visualist, :test_api_token)

  def show(conn, %{"id" => id}) do
    {status, response_epics} = Trackerx.call_get(@api_token, id, "/epics")
    {status, response_stories} = Trackerx.call_get(@api_token, id, "/stories")

    # render conn, "show.json", project: response_epics.body <> response_stories.body
    # render conn, "show.json", project: response_epics.body

    response = "{\"project\":["
      <> "{\"epics\":"    <> response_epics.body <> "}"
      <> ",{\"stories\":"  <> response_stories.body <> "}"
      <> "]}"
    conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, response)

    #TODO extract code to build properly formatted epics and stories json structure
    # Content-Type: application/json; charset=utf-8
  end
end
