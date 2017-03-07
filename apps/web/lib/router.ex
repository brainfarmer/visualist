defmodule Web.Router do
  @moduledoc """
  Main router for Visualist Web
  """

  use Plug.Router
  require Logger

  @module __MODULE__

  plug :match
  plug :dispatch


  #
  # Routes
  #
  get "/", do: send_resp(conn, 200, "Welcome from Visualist Web")

  forward "/api/v1", to: Web.APIRouter
    
  match _ do
    Logger.info("#{@module}: no route for #{conn.request_path}")
    send_resp(conn, 404, "Sorry, could not find #{conn.request_path}")
  end
  
end

  
