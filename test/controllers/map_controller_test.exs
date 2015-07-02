defmodule Trackermapper.MapControllerTest do
  use Trackermapper.ConnCase  # Phoenix connection testing helper
  use ExUnit.Case, ascync: false  # Can't by async if interacting wtih DB
  alias Trackermapper.Epic

   test "/map returns map view page" do
    conn = get conn(), "/map"
    assert conn.status == 200
   end

end
