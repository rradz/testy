defmodule Testy.Calc do
  @moduledoc "Simple calculator"

  def add(a, b) when is_integer(a) and is_integer(b) do
    a + b
  end

  def multiply(a, b) when is_integer(a) and is_integer(b) do
    a * b
  end
end
