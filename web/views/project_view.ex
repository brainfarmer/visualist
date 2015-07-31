defmodule Visualist.ProjectView do
  use Visualist.Web, :view

  def render("show.json", %{project: project}) do
    project
  end
end
