defmodule GraphqlUsersApi.Repo.Migrations.CreateCredentials do
  use Ecto.Migration

  def change do
    create table(:credentials) do
      add(:id, :binary_id, null: false, primary_key: true)
      add(:password_hash, :string)

      add(
        :user_id,
        references(:users, type: :binary_id, on_delete: :delete_all),
        null: false
      )

      timestamps()
    end

    create(index(:credentials, [:user_id]))
  end
end
