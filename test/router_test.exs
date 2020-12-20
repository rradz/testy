defmodule Testy.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts Testy.Router.init([])

  test "router shows that it's working" do
    conn = conn(:get, "/") |> Testy.Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "Hello, server is working."
  end

  test "router shows 404 for wrong routes" do
    conn = conn(:get, "/wrong_route") |> Testy.Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 404
    assert conn.resp_body == "Page not found."
  end
end
