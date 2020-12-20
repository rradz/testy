defmodule Testy.Websockets.Handler do
  @behaviour :cowboy_websocket
  require Logger

  def init(req, _state) do
    {:cowboy_websocket, req, %{}}
  end

  def websocket_init(_state) do
    Logger.info("Socket open")
    {:ok, %{}}
  end

  def websocket_handle({:binary, msg}, state) do
    {:ok, reply} = Pipeline.run(msg)

    {:reply, {:binary, reply}, state}
  end

  def websocket_handle({:text, msg}, state) do
    {:reply, {:text, msg}, state}
  end

  def websocket_info(msg, state) do
    Logger.warn("Unsupported message #{inspect(msg)} has been received by websocket process")
    {:ok, state}
  end

  def terminate(reason, _partial_req, _state) do
    Logger.info("Socket closed because of #{inspect(reason)}")

    :ok
  end
end
