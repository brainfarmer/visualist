defmodule Visualist.MapController do
  use Visualist.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, :index 
  end
end
