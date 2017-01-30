defmodule Mapping do

  alias Mapping.MapsSupervisor
  alias Mapping.MapServer
  

  def get_story_map(proj_id, api_token, opts \\[]) do
    id = start_map_server_aggregate(proj_id, api_token)
    Registry.lookup(Mapping.Registry, id)
    |> MapServer.get_story_map(opts)
  end
  
						  

  defp start_map_server_aggregate(proj_id, api_token) do
    id = random_name()
    MapsSupervisor.start_map_server(id, proj_id, api_token)
    id
  end
  
  defp random_name() do
    :rand.uniform()
  end
  
end
