defmodule Ext.Ecto.Changeset do
  @moduledoc """
  Custom extension to Ecto.Changeset module.
  """
  alias Ecto.Changeset

  @doc """
  Flattens an assoc field in the changeset, moving changes and errors from the
  association changeset to the parent changeset.

  Basically if I have a changeset like this:

    #Ecto.Changeset<action: :insert,
    changes: %{
      credential: #Ecto.Changeset<action: :insert,
        changes: %{email: "cat"},
        errors: [email: {"has invalid format", [validation: :format]},
        password: {"can't be blank", [validation: :required]}],
        data: #Impress.Accounts.Credential<>, valid?: false>
    },
    errors: [], ...>

  it gets converted to:

    #Ecto.Changeset<action: :insert,
    changes: %{
      email: "cat"
    },
    errors: [
      password: {"can't be blank", [validation: :required]},
      email: {"has invalid format", [validation: :format]},
      ...
    ], ...>
  """
  def flatten_assoc(changeset, field) do
    changeset
    |> flatten_assoc_changeset(changeset |> Changeset.get_change(field))
    |> Changeset.delete_change(field)
  end

  defp flatten_assoc_changeset(changeset, %Changeset{} = assoc_changeset) do
    changeset
    |> add_assoc_changes(assoc_changeset.changes |> Map.to_list())
    |> add_assoc_errors(assoc_changeset.errors)
  end

  defp flatten_assoc_changeset(changeset, _), do: changeset

  defp add_assoc_changes(changeset, [{field, value} | tail]) do
    changeset
    |> Changeset.put_change(field, value)
    |> add_assoc_changes(tail)
  end

  defp add_assoc_changes(changeset, _), do: changeset

  defp add_assoc_errors(changeset, [{field, {msg, opts}} | tail]) do
    changeset
    |> Changeset.add_error(field, msg, opts)
    |> add_assoc_errors(tail)
  end

  defp add_assoc_errors(changeset, _), do: changeset
end
