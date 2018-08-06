defmodule GraphqlUsersApi.Factory do
  use ExMachina.Ecto, repo: GraphqlUsersApi.Repo

  # --- ACCOUNTS

  def user_factory do
    %GraphqlUsersApi.Accounts.User{
      id: uuid(),
      username: sequence("Jane"),
      first_name: "Jane",
      last_name: sequence("Doe"),
      active: true
    }
  end

  # ---- HELPERS

  def hash_user_password(user) do
    %{user | password_hash: hash_password(user.password)}
  end

  def one_month_ago do
    {:ok, ecto_dt} = Timex.now() |> Timex.shift(months: -1) |> Ecto.DateTime.cast()
    ecto_dt
  end

  def now do
    {:ok, ecto_dt} = Timex.now() |> Ecto.DateTime.cast()
    ecto_dt
  end

  # Generates a random string
  # defp rand do
  #   Base.encode16(:crypto.strong_rand_bytes(8))
  # end

  defp hash_password(password) do
    Comeonin.Argon2.hashpwsalt(password)
  end

  defp uuid, do: UUID.uuid4()
end
