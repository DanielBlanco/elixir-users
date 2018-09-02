defmodule GraphqlUsersApiWeb.GraphQL.Schema do
  use Absinthe.Schema
  alias GraphqlUsersApiWeb.GraphQL, as: GQL
  alias GQL.Middleware
  alias Absinthe.Type, as: AbsTypes

  import_types(AbsTypes.Custom)
  import_types(GQL.Type.Account)

  query do
  end

  mutation do
    import_fields(:account_mutations)
  end

  @doc """
  Middlewares.
  """
  def middleware(middleware, _field, %AbsTypes.Object{identifier: :mutation}) do
    middleware ++ [Middleware.BinaryId, Middleware.ChangesetErrors]
  end

  def middleware(middleware, _field, %AbsTypes.Object{identifier: :query}) do
    middleware ++ [Middleware.BinaryId]
  end

  def middleware(middleware, _field, %AbsTypes.Object{identifier: :subscription}) do
    middleware ++ [Middleware.BinaryId]
  end

  def middleware(middleware, _field, _object), do: middleware
end
