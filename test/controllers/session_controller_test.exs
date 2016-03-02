defmodule Picty.SessionControllerTest do
  use Picty.ConnCase
  alias Picty.AdminUser

  @invalid_attrs %{username: "does not exist", password: "does not matter"}
  @valid_attrs %{username: "admin", password: "admin"}

  test "show login screen", %{conn: conn} do
    conn = get conn, session_path(conn, :signin)
    assert html_response(conn, 200) =~ "Username"
    assert html_response(conn, 200) =~ "Password"
  end

  test "authenticate not existing user and show error message", %{conn: conn} do

    conn = post conn, session_path(conn, :authenticate), admin_user: @invalid_attrs
    assert html_response(conn, 200) =~ "Oops, username and password dont match"

  end

  test "authenticate valid user with wrong password and show error message", %{conn: conn} do

    changeset = AdminUser.changeset(%AdminUser{}, @valid_attrs)
    assert changeset.valid?
    assert {:ok, _} = Repo.insert(changeset)

    conn = post conn, session_path(conn, :authenticate),
     admin_user: %{username: @valid_attrs["username"], password: "wrong"}
    assert html_response(conn, 200) =~ "Oops, username and password dont match"

  end

  test "authenticate valid user with valid password and redirect", %{conn: conn} do


    changeset = AdminUser.changeset(%AdminUser{}, @valid_attrs)
    assert changeset.valid?
    assert {:ok, _} = Repo.insert(changeset)

    conn = post conn, session_path(conn, :authenticate), admin_user: @valid_attrs
    assert redirected_to(conn, 302) == location_path(conn, :index)

  end


end
