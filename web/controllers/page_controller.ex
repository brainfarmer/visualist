defmodule Visualist.PageController do
  use Visualist.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
