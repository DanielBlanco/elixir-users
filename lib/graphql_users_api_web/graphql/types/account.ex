defmodule GraphqlUsersApiWeb.GraphQL.Type.Account do
  @moduledoc """
  GraphQL Type: account
  """
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Impress.Repo

  alias GraphqlUsersApiWeb.GraphQL.Resolver

  # ---- TYPES

  object :account do
    field(:id, :id)
    field(:username, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:active, :boolean)
    field(:inserted_at, :naive_datetime)
  end

  input_object :create_account_input, description: "create/update params" do
    field(:username, :string)
    field(:first_name, :string)
    field(:last_name, :string)
  end

  # ---- QUERY OBJECTS

  object :account_queries do
  end

  # ---- MUTATIONS

  object :account_mutations do
    @desc "Create an user account"
    field :create_account, type: :account do
      arg(:input, :create_account_input)

      # middleware Middleware.Authentication
      resolve(&Resolver.Account.Create.run/2)
    end
  end
end
