defmodule Testy.Websockets.Base.Transport.JSON do
  @behaviour Testy.Websockets.Base.Transport

  @impl Testy.Websockets.Base.Transport
  def decode(binary) do
    with {:ok, decoded} <- Jason.decode(binary) do
      req = %Testy.Websockets.Base.Request{
        ref: decoded["ref"],
        type: decoded["type"],
        payload: decoded["payload"]
      }

      {:ok, req}
    else
      _error -> {:error, :json_decoding_error}
    end
  end

  @impl Testy.Websockets.Base.Transport
  def encode(%Testy.Websockets.Base.Response{} = resp) do
    case Jason.encode(resp) do
      {:ok, encoded} -> {:ok, encoded}
      _error -> {:error, :json_encoding_error}
    end
  end
end
