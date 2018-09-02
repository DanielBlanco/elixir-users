defmodule GraphqlUsersApiWeb.GraphQL.Schema do
  @moduledoc """
  Absinthe GraphQL Schema.
  """
  use Absinthe.Schema
  alias Absinthe.Type, as: AbsTypes
  alias GraphqlUsersApiWeb.GraphQL, as: GQL
  alias GQL.Middleware

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
