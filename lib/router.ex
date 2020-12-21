defmodule Testy.Router do
  @moduledoc """
  Simply router so server state is checkable.
  """
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Hello, server is working.")
  end

  match _ do
    send_resp(conn, 404, "Page not found.")
  end
end
