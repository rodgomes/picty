defmodule Picty.LayoutView do
  use Picty.Web, :view

  def current_user(conn) do
    Plug.Conn.get_session(conn, :username)
  end

  def user_logged_in(conn) do
    Plug.Conn.get_session(conn, :username) != nil
  end

end
