defmodule GraphqlUsersApiWeb.GraphQL.Resolver.Account.Create do
  @moduledoc """
  Resolver that registers an user into the system.
  """
  alias GraphqlUsersApi.Accounts

  def run(args, _) do
    Accounts.create_user(args[:input]) |> response()
  end

  defp response(r), do: r
end
