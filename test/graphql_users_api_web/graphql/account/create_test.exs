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
       full_name
    }
  }
  """
  test "creates an user account", %{conn: conn} do
    input = %{
      "username" => "dblanco",
      "full_name" => "Daniel Blanco"
    }

    conn = post(conn, "/graphql", query: @query, variables: %{input: input})
    resp = json_response(conn, 200)
    account = resp["data"]["createAccount"]

    assert {:ok, _info} = UUID.info(account["id"])
    assert input["full_name"] == account["full_name"]
  end

  @query """
  mutation ($input: CreateAccountInput!)
  {
    createAccount(input: $input) {
       id
       full_name
    }
  }
  """
  test "fails to create account without full name", %{conn: conn} do
    input = %{"username" => "dblanco"}

    conn = post(conn, "/graphql", query: @query, variables: %{input: input})
    resp = json_response(conn, 200)
    fn_error = resp["errors"] |> List.first()

    assert "full_name: can't be blank" == fn_error["message"]
  end
end
