defmodule Testy.Websockets.Base.DispatcherTest do
  use ExUnit.Case, async: true
  alias Testy.Websockets.Base.{Request, Response}

  defmodule Test do
    def test(string), do: {:ok, "Hello, #{string}!"}

    def test2(_string), do: raise("Some mistake here")

    def test3(_string), do: {:error, "This function is not yet ready"}
  end

  defmodule TestDispatcher do
    use Testy.Websockets.Base.Dispatcher

    dispatch("test", to: Test, method: :test)
    dispatch("test2", to: Test, method: :test2)
    dispatch("test3", to: Test, method: :test3)
  end

  test "dispatch works for correct case" do
    req1 = %Request{
      ref: "req1",
      type: "test",
      payload: "world"
    }

    expected_response = %Response{
      ref: "req1",
      status: "ok",
      error: nil,
      payload: "Hello, world!"
    }

    assert ^expected_response = TestDispatcher.run(req1)
  end

  test "dispatch handles exceptions gracefully" do
    req2 = %Request{
      ref: "req2",
      type: "test2",
      payload: "world"
    }

    expected_response = %Response{
      ref: "req2",
      status: "error",
      error: "Some mistake here",
      payload: nil
    }

    assert ^expected_response = TestDispatcher.run(req2)
  end

  test "dispatch handles error cases" do
    req3 = %Request{
      ref: "req3",
      type: "test3",
      payload: "world"
    }

    expected_response = %Response{
      ref: "req3",
      status: "error",
      error: "This function is not yet ready",
      payload: nil
    }

    assert ^expected_response = TestDispatcher.run(req3)
  end

  test "dispatch handles missing types" do
    req4 = %Request{
      ref: "req4",
      type: "test4",
      payload: "world"
    }

    expected_response = %Response{
      ref: "req4",
      status: "error",
      error: "Request type test4 is not supported",
      payload: nil
    }

    assert ^expected_response = TestDispatcher.run(req4)
  end
end
