defmodule GraphqlUsersApiWeb.GraphQL.Middleware.BinaryId do
  @doc """
  GraphQL binary id checker.

  If the arguments don't have an ID to check, just continue.
  """
  @behaviour Absinthe.Middleware

  def call(resolution, _config) do
    case resolution.arguments do
      %{id: id} ->
        resolution |> validate_uuid(id)

      _ ->
        resolution
    end
  end

  defp validate_uuid(resolution, id) do
    case UUID.info(id) do
      {:error, _} ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "Invalid ID #{id}"})

      _ ->
        resolution
    end
  end
end
