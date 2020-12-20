defmodule Testy.Websockets.Base.Transport do
  @doc """
  Decodes a binary message
  """
  @callback decode(:binary) :: {:ok, Testy.Websockets.Base.Request.t()} | {:error, any()}

  @doc """
  Encodes a map.
  """
  @callback encode(Testy.Websockets.Base.Response.t()) :: {:ok, :binary} | {:error, any()}
end
