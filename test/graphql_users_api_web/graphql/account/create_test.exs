defmodule GraphqlUsersApiWeb.GraphQL.Account.CreateTest do
  use GraphqlUsersApiWeb.ConnCase, async: true

  # setup tags do
  #   {:ok, data} = tags |> setup_login(:admin)
  #   {:ok, data ++ [user: user]}
  # end

  @query """
  mutation ($input: CreateAccountInput!)
  {
    createAccount(input: $input) {
       id
       first_name
       last_name
    }
  }
  """
  test "creates an user account", %{conn: conn} do
    input = %{
      "username" => "dblanco",
      "first_name" => "Daniel",
      "last_name" => "Blanco"
    }

    conn = post(conn, "/graphql", query: @query, variables: %{input: input})
    resp = json_response(conn, 200)
    account = resp["data"]["createAccount"]

    assert {:ok, _info} = UUID.info(account["id"])
    assert input["first_name"] == account["first_name"]
    assert input["last_name"] == account["last_name"]
  end
end
