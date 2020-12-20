defmodule Testy.Base.Transport do
  @doc """
  Decodes a binary message
  """
  @callback decode(:binary) :: {:ok, Testy.Base.Request.t()} | {:error, :atom}

  @doc """
  Encodes a map.
  """
  @callback encode(Testy.Base.Response.t()) :: {:ok, :binary} | {:error, :atom}
end
