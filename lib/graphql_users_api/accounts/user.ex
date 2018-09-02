defmodule GraphqlUsersApi.Accounts.User do
  @moduledoc """
  User model.
  """
  use GraphqlUsersApi.Schema
  import Ecto.Changeset

  schema "users" do
    field(:active, :boolean, default: false)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:username, :string)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:id, :first_name, :last_name, :username, :active])
    |> validate_required([:first_name, :last_name, :username, :active])
    |> validate_length(:first_name, min: 1, max: 50)
    |> validate_length(:last_name, min: 1, max: 50)
    |> validate_length(:username, min: 1, max: 50)
    |> unique_constraint(:username)
    |> unique_constraint(:id, name: :users_pkey)
  end
end
