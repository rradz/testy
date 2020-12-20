defmodule Testy.Websockets.Pipeline do
  @moduledoc "Message processing pipeline"

  @transport_map %{
    json: Testy.Base.Transport.JSON
  }

  def run(msg, transport: transport) do
    transport = Map.get(@transport_map, transport, Testy.Base.Transport.JSON)

    with {:ok, decoded} <- transport.decode(msg),
         {:ok, processed} <- Testy.Websockets.Dispatch.run(decoded),
         {:ok, encoded} <- transport.encode(processed) do
      {:ok, encoded}
    end
  end
end
