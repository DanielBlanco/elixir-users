defmodule GraphqlUsersApiWeb.GraphQL.Resolver.Account.Create do
  @moduledoc """
  Resolver that registers an user into the system.
  """
  alias GraphqlUsersApi.Accounts

  def run(args, _) do
    Accounts.create_user(args[:input]) |> response()
  end

  # defp response({:error, chset}) do
  #   errors = chset |> changeset_errors()
  #   {:error, %{message: "Could not register account", details: errors}}
  # end

  defp response(r), do: r

  # def changeset_errors(chset) do
  #   chset |> Ecto.Changeset.traverse_errors(fn {msg, _} -> msg end)
  # end
end
