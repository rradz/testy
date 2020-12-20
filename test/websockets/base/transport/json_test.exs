defmodule Testy.Websockets.Base.Transport.JSONTest do
  use ExUnit.Case, async: true
  alias Testy.Websockets.Base.{Request, Response, Transport.JSON}

  test "correctly decodes JSON" do
    json = ~s({
      "ref": "01",
      "type": "type",
      "payload": {
        "a": 1,
        "b": 2
      }
    })

    assert {:ok, %Request{ref: "01", type: "type", payload: %{"a" => 1, "b" => 2}}} =
             JSON.decode(json)
  end

  test "correctly handles decoding invalid JSON" do
    invalid_json = "foo"

    assert {:error, :json_decoding_error} = JSON.decode(invalid_json)
  end

  test "correctly encodes response" do
    resp = %Response{
      ref: "01",
      status: "ok",
      error: nil,
      payload: %{result: 2}
    }

    assert {:ok, ~s({"ref":"01","status":"ok","error":null,"payload":{"result":2}})} =
             JSON.encode(resp)
  end

  test "correctly handles encoding problems" do
    resp = %Response{
      ref: "01",
      status: "ok",
      error: nil,
      payload: {"result", nil}
    }

    assert {:error, :json_encoding_error} = JSON.encode(resp)
  end
end
