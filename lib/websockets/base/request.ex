defmodule Testy.Websockets.Base.Request do
  @derive {Jason.Encoder, only: [:ref, :type, :payload]}
  defstruct([:ref, :type, :payload])
end
