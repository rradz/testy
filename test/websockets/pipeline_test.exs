defmodule Testy.Websockets.PipelineTest do
  use ExUnit.Case, async: true
  alias Testy.Websockets.Base.{Request, Response}
  alias Testy.Websockets.Pipeline

  test "pipeline works for add request" do
    req = %Request{ref: 1, type: "add", payload: %{a: 1, b: 2}}
    expected_resp = %Response{ref: 1, status: "ok", error: nil, payload: %{result: 3}}
    json_req = Jason.encode!(req)
    expected_json_resp = Jason.encode!(expected_resp)

    assert {:ok, ^expected_json_resp} = Pipeline.run(json_req, transport: "json")
  end

  test "pipeline works for multiply request" do
    req = %Request{ref: 1, type: "multiply", payload: %{a: 1, b: 2}}
    expected_resp = %Response{ref: 1, status: "ok", error: nil, payload: %{result: 2}}
    json_req = Jason.encode!(req)
    expected_json_resp = Jason.encode!(expected_resp)

    assert {:ok, ^expected_json_resp} = Pipeline.run(json_req, transport: "json")
  end

  test "pipeline works for unsupported request" do
    req = %Request{ref: 1, type: "divide", payload: %{a: 1, b: 2}}

    expected_resp = %Response{
      ref: 1,
      status: "error",
      error: "Request type divide is not supported",
      payload: nil
    }

    json_req = Jason.encode!(req)
    expected_json_resp = Jason.encode!(expected_resp)

    assert {:ok, ^expected_json_resp} = Pipeline.run(json_req, transport: "json")
  end

  test "pipeline handles correctly pops errors up" do
    json_req = "foo"

    assert {:error, :json_decoding_error} = Pipeline.run(json_req, transport: "json")
  end

  test "not specified transport is defaulted to json" do
    json_req = "foo"

    assert {:error, :json_decoding_error} = Pipeline.run(json_req, transport: nil)
  end

  test "unsupported transport returns error" do
    req = "foo"

    assert {:error, :unsupported_transport} = Pipeline.run(req, transport: "text")
  end
end
