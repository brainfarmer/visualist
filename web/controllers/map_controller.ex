defmodule Trackermapper.MapController do
  use Trackermapper.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, :index 
  end
end
