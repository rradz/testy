defmodule Testy.Websockets.Pipeline do
  @moduledoc "Message processing pipeline"

  @default_transport Testy.Websockets.Base.Transport.JSON

  @transport_map %{
    "json" => Testy.Websockets.Base.Transport.JSON
  }

  def run(msg, transport: transport_param) do
    with {:ok, transport} <- get_transport(transport_param),
         {:ok, decoded} <- transport.decode(msg),
         {:ok, processed} <- Testy.Websockets.Dispatcher.run(decoded),
         {:ok, encoded} <- transport.encode(processed) do
      {:ok, encoded}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp get_transport(transport_param) do
    if transport_param do
      case Map.get(@transport_map, transport_param) do
        nil -> {:error, :unsupported_transport}
        transport -> {:ok, transport}
      end
    else
      {:ok, @default_transport}
    end
  end
end
