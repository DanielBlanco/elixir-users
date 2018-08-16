defmodule GraphqlUsersApiWeb.GraphQL.Plug.Context do
  @doc """
  GraphQL context for Absinthe.
  """
  @behaviour Plug

  # import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    conn
    # case Guardian.Plug.current_resource(conn) do
    #   nil ->
    #     conn

    #   user ->
    #     context = build_context(conn, user)
    #     put_private(conn, :absinthe, %{context: context})
    # end
  end

  # defp build_context(conn, user) do
  #   %{
  #     current_user: user,
  #     jwt: Guardian.Plug.current_token(conn),
  #     claims: Guardian.Plug.claims(conn)
  #   }
  # end
end
