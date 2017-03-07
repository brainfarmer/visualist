defmodule WebRouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts Web.Router.init([])
  @test_project_id 1334474
  @test_api_token "aa6c95ad3b28fa8520fa75b298a533f4"

  test "/ returns index" do
    conn = conn(:get, "/")
    conn = Web.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
  end


  test "invalid route returns 404 error" do
    conn = conn(:get, "/adxda")
    conn = Web.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 404
  end


  test "valid api route returns json" do
    conn = conn(:get, "/api/v1/storymaps/#{@test_project_id}/#{@test_api_token}")
    conn = Web.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200

    {"content-type", value} = List.keyfind(conn.resp_headers, "content-type", 0)
    assert value == "application/json; charset=utf-8"
  end
  
  
end
