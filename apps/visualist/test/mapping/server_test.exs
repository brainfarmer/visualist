defmodule Mapping.ServerTest do
  use ExUnit.Case, async: true
  

  @project_id 1389518
  @api_token "aa6c95ad3b28fa8520fa75b298a533f4"
  
  setup context do
    {:ok, mapping_server} = Mapping.Server.start_link([name: context.test])
    {:ok, mapping_server: mapping_server}
  end

  
#  test "true test", %{mapping_server: mapping_server} do
  test "true test" do    
    assert true
  end

  test "gets story map", %{mapping_server: mapping_server} do
    assert {:ok, _} = Mapping.Server.get_story_map(Mapping.Server, "test",
      @project_id, @api_token)
  end
  

  
  
end
