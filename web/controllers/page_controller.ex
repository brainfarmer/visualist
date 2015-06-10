defmodule Trackermapper.PageController do
  use Trackermapper.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
