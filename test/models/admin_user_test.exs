defmodule Picty.AdminUserTest do
  use Picty.ModelCase

  alias Picty.AdminUser

  @valid_attrs %{password: "some content", username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = AdminUser.changeset(%AdminUser{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = AdminUser.changeset(%AdminUser{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with small password" do
    changeset = AdminUser.changeset(%AdminUser{}, %{password: "a"})
    refute changeset.valid?
  end

  test "changeset with duplicated username" do
    first = AdminUser.changeset(%AdminUser{}, @valid_attrs)
    assert {:ok, _} = Repo.insert(first)

    duplicated_user = AdminUser.changeset(%AdminUser{}, @valid_attrs)
    assert {:error, changeset} = Repo.insert(duplicated_user)
    refute changeset.valid?
  end

  test "password is encrypted" do
    changeset = AdminUser.changeset(%AdminUser{}, @valid_attrs)
    assert changeset.valid?
    assert {:ok, admin_user} = Repo.insert(changeset)
    assert admin_user.password != @valid_attrs["password"]
  end

  test "check_password encrypted empty username and password" do
    refute AdminUser.check_password(nil, nil)
  end

  test "check_password encrypted empty username" do
    refute AdminUser.check_password(nil, "aaa")
  end

  test "check_password encrypted wrong password" do
    changeset = AdminUser.changeset(%AdminUser{}, @valid_attrs)
    assert changeset.valid?
    assert {:ok, _} = Repo.insert(changeset)
    refute AdminUser.check_password(@valid_attrs[:username], "wrong")
  end

  test "check_password user not found" do
    refute AdminUser.check_password("wrong username", "does not matter")
  end

  test "check_password encrypted correct password" do
    changeset = AdminUser.changeset(%AdminUser{}, @valid_attrs)
    assert changeset.valid?
    assert {:ok, admin_user} = Repo.insert(changeset)
    assert AdminUser.check_password(admin_user.username, @valid_attrs[:password])
  end

end
