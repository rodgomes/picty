defmodule Picty.Plugs.AdminAuthenticate do
  import Plug.Conn
  import Phoenix.Controller

  def init(default), do: default

  def call(conn, _default) do
    current_user = get_session(conn, :username)
    if current_user == nil do
      conn
        |> put_flash(:error, "Hey, you can't access that page without logging in first!")
        |> redirect(to: Picty.Router.Helpers.session_path(conn, :signin))
    else
      conn
    end
  end
end
