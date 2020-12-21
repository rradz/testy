defmodule Testy do
  @moduledoc """
  Supervisor for whole application.
  """
  use Application

  def start(_type, _args) do
    children = [
      {Plug.Cowboy,
       scheme: :http,
       plug: Testy.Router,
       options: [
         dispatch: [
           {:_,
            [
              {"/ws", Testy.Websockets.Handler, []},
              {:_, Plug.Adapters.Cowboy.Handler, {Testy.Router, []}}
            ]}
         ],
         port: 4001
       ]}
    ]

    opts = [strategy: :one_for_one, name: Testy.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
