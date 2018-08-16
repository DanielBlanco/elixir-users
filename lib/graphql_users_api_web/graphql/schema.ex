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
  This will be applied to ALL fields.
  """
  def middleware(middleware, _field, %AbsTypes.Object{identifier: identifier})
      when identifier in [:query, :subscription, :mutation] do
    [Middleware.BinaryId | middleware]
  end

  def middleware(middleware, _field, _object) do
    middleware
  end
end
