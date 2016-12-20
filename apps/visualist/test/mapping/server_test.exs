defmodule Mapping.ServerTest do
  use ExUnit.Case, async: true
  
  alias Mapping.Server
  alias Mapping.StoryMap.SMap

  @project_id 1389518
  @api_token "aa6c95ad3b28fa8520fa75b298a533f4"
  
  @updated_id 1
  @updated_token "a"
  
  setup  do
    {:ok, mapping_server} = Server.start_link(["test", @project_id, @api_token] )

    {:ok, mapping_server: mapping_server}
  end

  
  test "server is initialized with project_id and api token", %{mapping_server: mapping_server} do
    assert %{project_id: @project_id, api_token: @api_token} = Server.get_state(mapping_server)
  end
  

  test "get current state story map", %{mapping_server: mapping_server} do
    default_map = %SMap{}
    assert Server.get_story_map(mapping_server).story_map == default_map
  end

  
#  @tag :pending
  test "update project credentials", %{mapping_server: mapping_server} do
    assert Server.update_credentials(mapping_server, @updated_id, @updated_token) == :ok
    assert %{project_id: @updated_id, api_token: @updated_token} = Server.get_state(mapping_server)
  end

   @tag :pending
  test "generate story map", %{mapping_server: mapping_server} do
  end
  
end
