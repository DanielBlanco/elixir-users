defmodule GraphqlUsersApiWeb.Router do
  use GraphqlUsersApiWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
    # plug GraphqlUsersApiWeb.Plug.BinaryId
  end

  pipeline :graphql do
    plug(GraphqlUsersApiWeb.GraphQL.Plug.Context)
  end

  scope "/", GraphqlUsersApiWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  scope "/graphql" do
    pipe_through([:api, :graphql])

    forward(
      "/graphiql",
      Absinthe.Plug.GraphiQL,
      schema: GraphqlUsersApiWeb.GraphQL.Schema
    )

    forward("/", Absinthe.Plug, schema: GraphqlUsersApiWeb.GraphQL.Schema)
  end

  # Other scopes may use custom stacks.
  # scope "/api", GraphqlUsersApiWeb do
  #   pipe_through :api
  # end
end
