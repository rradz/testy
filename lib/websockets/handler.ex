defmodule Testy.Websockets.Handler do
  @moduledoc """
  Module implementing Cowboy's Websocket behaviour to handle websocket connections.
  """
  @behaviour :cowboy_websocket
  require Logger
  alias Testy.Websockets.Pipeline

  # Callback implementation

  @impl :cowboy_websocket
  def init(req, _state) do
    transport = req |> :cowboy_req.parse_qs() |> Enum.into(%{}) |> Map.get("transport")

    {:cowboy_websocket, req, %{transport: transport}}
  end

  @impl :cowboy_websocket
  def websocket_init(state) do
    Logger.info("Socket open")
    {:ok, state}
  end

  @impl :cowboy_websocket
  def websocket_handle({:text, msg}, state) do
    process_message(msg, :text, state.transport)

    {:ok, state}
  end

  @impl :cowboy_websocket
  def websocket_handle({:binary, msg}, state) do
    process_message(msg, :binary, state.transport)
    {:ok, state}
  end

  @impl :cowboy_websocket
  def websocket_info({:respond, ws_type, reply}, state) do
    {:reply, {ws_type, reply}, state}
  end

  @impl :cowboy_websocket
  def websocket_info({:EXIT, _pid, :normal}, state) do
    # So messages informing about linked process exiting normally don't clutter the log.
    {:ok, state}
  end

  @impl :cowboy_websocket
  def websocket_info({:terminate, reason}, state) do
    Logger.error("Something went badly due to #{reason}")

    {:stop, state}
  end

  @impl :cowboy_websocket
  def websocket_info(msg, state) do
    Logger.warn("Unsupported message #{inspect(msg)} has been received by websocket process")

    {:ok, state}
  end

  @impl :cowboy_websocket
  def terminate(reason, _partial_req, _state) do
    Logger.info("Socket closed because of #{inspect(reason)}")

    :ok
  end

  # A bit of process handling logic
  #
  defp process_message(msg, ws_type, transport) do
    # PID of the running connection
    connection_pid = self()

    # We spawn the process to do the work, spawned process sends a message back when it's done
    # Process is linked, so when unexpected exception happens, we shutdown the connection

    Process.spawn(
      fn ->
        case Pipeline.run(msg, transport: transport) do
          {:ok, reply} -> send(connection_pid, {:respond, ws_type, reply})
          {:error, reason} -> send(connection_pid, {:terminate, reason})
        end
      end,
      [:link]
    )
  end
end
