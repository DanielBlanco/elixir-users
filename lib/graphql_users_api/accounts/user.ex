defmodule GraphqlUsersApi.Accounts.User do
  @moduledoc """
  User model.
  """
  use GraphqlUsersApi.Schema
  import Ecto.Changeset
  alias GraphqlUsersApi.Accounts.{Credential, User}

  schema "users" do
    field(:active, :boolean, default: false)
    field(:full_name, :string)
    field(:username, :string)

    has_one(:credential, Credential, on_replace: :update, on_delete: :delete_all)
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:id, :username, :full_name, :active])
    |> validate_required([:username, :full_name, :active])
    |> validate_length(:username, min: 1, max: 50)
    |> validate_length(:full_name, min: 1, max: 100)
    |> unique_constraint(:username)
    |> unique_constraint(:id, name: :users_pkey)
  end
end
