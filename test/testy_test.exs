defmodule TestyTest do
  use ExUnit.Case
  doctest Testy

  test "greets the world" do
    assert Testy.hello() == :world
  end
end
