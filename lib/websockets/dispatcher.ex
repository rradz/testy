defmodule Testy.Websockets.Dispatcher do
  use Testy.Websockets.Base.Dispatcher
  alias Testy.Websockets.MessageHandler

  dispatch("add", to: MessageHandler, method: :add)
  dispatch("multiply", to: MessageHandler, method: :multiply)
end
