defmodule Testy.Websockets.Base.Response do
  @moduledoc """
  Basic response format. Ref is a request identifier set by client, matching the ref in request.
  Status is a string indicating whether everything went fine or not, error provides error message if necessary.
  Payload contains the response body.
  """
  @type t :: %__MODULE__{
          ref: any(),
          status: String.t(),
          error: String.t() | nil,
          payload: any()
        }

  @derive {Jason.Encoder, only: [:ref, :status, :error, :payload]}

  defstruct([:ref, :status, :error, :payload])
end
