defmodule Web.APIRouter do
  @moduledoc """
  Routing for API routes
  """

  use Plug.Router
  require Logger

  @module __MODULE__

  plug :match
  plug :dispatch

  get "/storymaps/:id/:token" do
    conn
    |> Web.StoryMapController.get_story_map(id, token, :json)
    |> respond
  end


  match _ do
    Logger.info("#{@module}: No router for #{conn.request_path}")
    send_resp(conn, 404, "Could not find #{conn.request_path}")
  end


  defp respond(conn) do
    conn
    |> Plug.Conn.put_resp_content_type("application/json")
    |> Plug.Conn.send_resp
  end


end
