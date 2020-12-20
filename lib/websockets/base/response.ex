defmodule Testy.Websockets.Base.Response do
  @derive {Jason.Encoder, only: [:ref, :status, :error, :payload]}
  defstruct([:ref, :status, :error, :payload])
end
