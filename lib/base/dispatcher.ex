defmodule Testy.Base.Dispatcher do
  defmacro __using__(_opts) do
    Module.register_attribute(__MODULE__, :routes, accumulate: true)
  end

  defmacro route(msg_type, to: module, method: method) do
    quote do
      @routes {msg_type, {module, method}}
    end
  end

  defmacro dispatch(msg, opts) do
    quote do
      def dispatch(msg, _opts) do
      end
    end
  end
end
