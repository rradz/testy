defmodule Testy.Websockets.Base.Request do
  @moduledoc """
  Our basic request format. Ref is a request identifier set by client, type is the type of message sent,
  payload has to contain the structure understandable by message handler.
  """
  @type t :: %__MODULE__{
          ref: any(),
          type: String.t(),
          payload: any()
        }

  @derive {Jason.Encoder, only: [:ref, :type, :payload]}

  defstruct([:ref, :type, :payload])
end
