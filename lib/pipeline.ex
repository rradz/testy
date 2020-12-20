defmodule Testy.Pipeline do
  @moduledoc "Message processing pipeline"

  @transport_map %{
    json: Testy.Base.Transport.JSON
  }

  def run(msg, transport: transport) do
    transport = Map.get(@transport_map, transport, Testy.Base.Transport.JSON)

    with {:ok, decoded} <- transport.decode(msg),
         {:ok, processed} <- Dispatch.process(decoded),
         {:ok, encoded} <- transport.encode(processed) do
      {:ok, encoded}
    else
      _ -> {:error, :processing_error}
    end
  end
end
