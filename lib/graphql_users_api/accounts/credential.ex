defmodule GraphqlUsersApi.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset

  schema "credentials" do
    field(:password, :string, virtual: true)
    field(:password_hash, :string)

    belongs_to(:user, User)
    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> unique_constraint(:email)
  end

  # Encrypts the password.
  defp put_pass_hash(changeset = %Ecto.Changeset{valid?: true, changes: %{password: p}}) do
    changeset
    |> put_change(:password_hash, Comeonin.Argon2.hashpwsalt(p))
    |> put_change(:password, nil)
  end

  defp put_pass_hash(changeset), do: changeset
end
