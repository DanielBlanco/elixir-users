defmodule GraphqlUsersApi.AccountsTest do
  use GraphqlUsersApi.DataCase

  alias GraphqlUsersApi.Accounts

  describe "users" do
    alias GraphqlUsersApi.Accounts.User

    @valid_attrs %{
      active: true,
      username: "username",
      full_name: "some full_name"
    }
    @update_attrs %{
      active: false,
      username: "updated_username",
      full_name: "some updated full_name"
    }
    @invalid_attrs %{
      active: nil,
      username: nil,
      full_name: nil
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
      assert user.full_name == "some full_name"
      assert user.username == "username"
      assert {:ok, _info} = UUID.info(user.id)
    end

    test "create_user/1 with custom ID" do
      attrs = Map.put(@valid_attrs, :id, UUID.uuid4())
      assert {:ok, %User{} = user} = Accounts.create_user(attrs)
      assert attrs[:id] == user.id
    end

    test "create_user/1 with invalid username" do
      test_attrs = Map.put(@valid_attrs, :username, nil)
      assert {:error, chset} = Accounts.create_user(test_attrs)
      assert %{username: ["can't be blank"]} = errors_on(chset)
    end

    test "create_user/1 with blank username" do
      test_attrs = Map.put(@valid_attrs, :username, "")
      assert {:error, chset} = Accounts.create_user(test_attrs)
      assert %{username: ["can't be blank"]} = errors_on(chset)
    end

    test "create_user/1 with username longer than 50 chars" do
      test_attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 51))
      assert {:error, chset} = Accounts.create_user(test_attrs)
      assert %{username: ["should be at most 50 character(s)"]} = errors_on(chset)
    end

    test "create_user/1 with duplicate username" do
      user = user_fixture()
      test_attrs = Map.put(@valid_attrs, :username, user.username)
      assert {:error, chset} = Accounts.create_user(test_attrs)
      assert %{username: ["has already been taken"]} = errors_on(chset)
    end

    test "create_user/1 with invalid full_name" do
      test_attrs = Map.put(@valid_attrs, :full_name, nil)
      assert {:error, chset} = Accounts.create_user(test_attrs)
      assert %{full_name: ["can't be blank"]} = errors_on(chset)
    end

    test "create_user/1 with blank full_name" do
      test_attrs = Map.put(@valid_attrs, :full_name, "")
      assert {:error, chset} = Accounts.create_user(test_attrs)
      assert %{full_name: ["can't be blank"]} = errors_on(chset)
    end

    test "create_user/1 with full_name longer than 100 chars" do
      test_attrs = Map.put(@valid_attrs, :full_name, String.duplicate("a", 101))
      assert {:error, chset} = Accounts.create_user(test_attrs)
      assert %{full_name: ["should be at most 100 character(s)"]} = errors_on(chset)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.active == false
      assert user.full_name == "some updated full_name"
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

  describe "credentials" do
    alias GraphqlUsersApi.Accounts.Credential

    @valid_attrs %{password: "some password"}
    @update_attrs %{password: "some updated email"}
    @invalid_attrs %{password: nil}

    def credential_fixture(attrs \\ %{}) do
      {:ok, credential} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_credential()

      credential
    end

    test "list_credentials/0 returns all credentials" do
      credential = credential_fixture()
      assert Accounts.list_credentials() == [credential]
    end

    test "get_credential!/1 returns the credential with given id" do
      credential = credential_fixture()
      assert Accounts.get_credential!(credential.id) == credential
    end

    test "create_credential/1 with valid data creates a credential" do
      assert {:ok, %Credential{} = credential} = Accounts.create_credential(@valid_attrs)
      assert credential.email == "some email"
    end

    test "create_credential/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_credential(@invalid_attrs)
    end

    test "update_credential/2 with valid data updates the credential" do
      credential = credential_fixture()
      assert {:ok, credential} = Accounts.update_credential(credential, @update_attrs)
      assert %Credential{} = credential
      assert credential.email == "some updated email"
    end

    test "update_credential/2 with invalid data returns error changeset" do
      credential = credential_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_credential(credential, @invalid_attrs)
      assert credential == Accounts.get_credential!(credential.id)
    end

    test "delete_credential/1 deletes the credential" do
      credential = credential_fixture()
      assert {:ok, %Credential{}} = Accounts.delete_credential(credential)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_credential!(credential.id) end
    end

    test "change_credential/1 returns a credential changeset" do
      credential = credential_fixture()
      assert %Ecto.Changeset{} = Accounts.change_credential(credential)
    end
  end
end
