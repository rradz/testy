defmodule Testy.CalcTest do
  use ExUnit.Case, async: true

  test "adding works" do
    assert 4 == Testy.Calc.add(2, 2)
  end

  test "multiplying works" do
    assert 6 == Testy.Calc.multiply(2, 3)
  end

  test "adding raises error for incorrect input" do
    assert_raise FunctionClauseError, ~r/.*/, fn ->
      Testy.Calc.add("hello", 1)
    end
  end

  test "multiplying raises error for incorrect input" do
    assert_raise FunctionClauseError, ~r/.*/, fn ->
      Testy.Calc.multiply(1.0, 2)
    end
  end
end
