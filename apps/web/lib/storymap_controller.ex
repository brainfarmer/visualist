defmodule Web.StoryMapController do
  @moduledoc """
  Controller to handle storymap routes
  """

  alias Plug.Conn

  def get_story_map(conn, project_id, api_token, :json) do
    case is_valid_project_id_format(project_id) do
      true -> _get_story_map(conn, project_id, api_token)
      false -> Conn.resp(conn, 404, "Invalid project id format. Id should be an integer")
    end
  end


  defp _get_story_map(conn, project_id, api_token) do
    case Mapping.get_story_map(project_id, api_token) do
      {:ok, storymap} ->
	{:ok, storymap_json} = JSON.encode(storymap)
	Conn.resp(conn, 200, storymap_json)

      {:error, message} -> Conn.resp(conn, 404, message)
    end
  end

  
  defp is_valid_project_id_format(string) do
    string =~ ~r/^[0-9]*$/ 
  end  
end
