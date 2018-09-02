defmodule GraphqlUsersApi.Schema do
  @moduledoc """
  Custom Ecto Schema.

  Keep in mind that Models you create must use this module instead of Ecto's.
  """
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
    end
  end
end
