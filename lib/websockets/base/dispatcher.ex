defmodule Testy.Websockets.Base.Dispatcher do
  @moduledoc """
  Module intended to facilitate creating dispatchers, routers for websocket requests. Example use:
  `
  defmodule MyDispatcher do
    use Testy.Websockets.Base.Dispatcher

    dispatch "request_type", to: MyHandlerModule, method: :my_handler_function
  end
  `

  It is assumed that handler methods adhere to return spec {:ok, any()} | {:error, String.t()}
  """

  defmacro __using__(_opts) do
    quote do
      import Testy.Websockets.Base.Dispatcher

      Module.register_attribute(__MODULE__, :routes, accumulate: true)

      @before_compile Testy.Websockets.Base.Dispatcher
    end
  end

  defmacro dispatch(req_type, to: module, method: method) do
    quote do
      @routes {unquote(req_type), {unquote(module), unquote(method)}}
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      @compiled_routes Enum.into(@routes, %{})

      def run(%Testy.Websockets.Base.Request{} = request) do
        case Map.get(@compiled_routes, request.type) do
          nil -> error_response(request, "Request type #{request.type} is not supported")
          {module, method} -> process_request(request, module, method)
        end
      end
    end
  end

  def process_request(request, module, method) do
    try do
      case apply(module, method, [request.payload]) do
        {:ok, response} -> ok_response(request, response)
        {:error, error_message} -> error_response(request, error_message)
      end
    rescue
      e -> error_response(request, Exception.message(e))
    end
  end

  def ok_response(request, response) do
    {:ok,
     %Testy.Websockets.Base.Response{
       ref: request.ref,
       status: "ok",
       error: nil,
       payload: response
     }}
  end

  def error_response(request, error_message) do
    {:ok,
     %Testy.Websockets.Base.Response{
       ref: request.ref,
       status: "error",
       error: error_message,
       payload: nil
     }}
  end
end
