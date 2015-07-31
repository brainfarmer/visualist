defmodule Visualist.ProjectController do
  use Visualist.Web, :controller

  def show(conn, %{"id" => id}) do
    api_token = conn |> get_req_header("api_token")

    {status, response_epics} = Trackerx.call_get(api_token, id, "/epics")
    {status, response_stories} = Trackerx.call_get(api_token, id, "/stories")
    render conn, "show.json", project: response_epics.body <> response_stories.body

    #TODO extract code to build properly formatted epics and stories json structure
  end
end
