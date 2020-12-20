defmodule Testy.Websockets.MessageHandler do
  @moduledoc """
  Handles incoming messages and calls appropriate methods.

  Add message proper payload: %{"a" => first_integer_argument, "b" => second_integer_argument}
  Multiply message proper payload: %{"a" => first_integer_argument, "b" => second_integer_argument}
  """

  def add(%{"a" => a, "b" => b}) do
    {:ok, %{result: Testy.Calc.add(a, b)}}
  end

  def multiply(%{"a" => a, "b" => b}) do
    {:ok, %{result: Testy.Calc.multiply(a, b)}}
  end
end
