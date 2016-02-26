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

  test "changeset with small password attributes" do
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

end
