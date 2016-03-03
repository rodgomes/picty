defmodule Picty.SessionController do
  use Picty.Web, :controller
  alias Picty.AdminUser

  plug :put_layout, "session.html"

  def signin(conn, _params) do
    changeset = AdminUser.auth_changeset(%AdminUser{})
    render conn, "login.html", changeset: changeset
  end

  def authenticate(conn, %{"admin_user" => params}) do

      changeset = AdminUser.auth_changeset(%AdminUser{}, params)
      if changeset.valid? do
        conn
        |> put_flash(:info, "Welcome!")
        |> put_session(:username, changeset.params["username"])
        |> redirect(to: location_path(conn, :index))
      else
        render conn, "login.html", changeset: changeset
      end
  end

  def signout(conn, _params) do

    conn
    |> clear_session
    |> put_flash(:info, "Logged out successfully!")
    |> redirect(to: session_path(conn, :signin))
  end

end
