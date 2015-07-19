defmodule Visualist.MapControllerTest do
  use Visualist.ConnCase  # Phoenix connection testing helper
  use ExUnit.Case, ascync: false  # Can't by async if interacting wtih DB

   test "/map/:project_id returns epics and stories as json" do
    conn = get conn(), "/map"
    assert conn.status == 200
    assert conn.resp_body # contain json for epics
    assert conn.resp_body # contains json for stories
   end

end
