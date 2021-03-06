defmodule Visualist do
  @moduledoc """
  Contains main business logic for Visualist
  """

  def get_story_map(proj_id, api_token, opts \\[]) do
    name = random_name()
    Mapping.Server.get_story_map(Mapping.Server, name, proj_id, api_token)
  end


  defp random_name() do
    :rand.uniform()
  end
  
end

