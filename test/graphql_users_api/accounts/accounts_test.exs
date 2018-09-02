defmodule GraphqlUsersApi.AccountsTest do
  use GraphqlUsersApi.DataCase

  alias GraphqlUsersApi.Accounts

  describe "users" do
    alias GraphqlUsersApi.Accounts.User

    @valid_attrs %{
      active: true,
      first_name: "some first_name",
      last_name: "some last_name",
      username: "username"
    }
    @update_attrs %{
      active: false,
      first_name: "some updated first_name",
      last_name: "some updated last_name",
      username: "updated_username"
    }
    @invalid_attrs %{
      active: nil,
      first_name: nil,
      last_name: nil,
      username: nil
    }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.active == true
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.username == "username"
    end

    test "create_user/1 with invalid username" do
      test_attrs = Map.put(@valid_attrs, :username, nil)
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(test_attrs)
    end

    test "create_user/1 with blank username" do
      test_attrs = Map.put(@valid_attrs, :username, "")
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(test_attrs)
    end

    test "create_user/1 with username longer than 50 chars" do
      test_attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 51))
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(test_attrs)
    end

    test "create_user/1 with duplicate username" do
      user = user_fixture()
      test_attrs = Map.put(@valid_attrs, :username, user.username)
      assert {:error, chset} = Accounts.create_user(test_attrs)
      assert %{username: ["has already been taken"]} = errors_on(chset)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.active == false
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.username == "updated_username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
