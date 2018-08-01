defmodule GraphqlUsersApiWeb.PageController do
  use GraphqlUsersApiWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
