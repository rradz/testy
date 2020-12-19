defmodule Testy.WebsocketHandler do
  @behaviour :cowboy_websocket
  require Logger

  def init(req, _state) do
    {:cowboy_websocket, req, %{}}
  end

  def websocket_init(_state) do
    Logger.info("Socket open")
    {:ok, %{}}
  end

  def websocket_handle({:text, msg}, state) do
    {:reply, {:text, msg}, state}
  end

  def websocket_info(msg, state) do
    {:ok, state}
  end
end
