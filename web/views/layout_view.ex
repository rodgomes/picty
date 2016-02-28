defmodule Picty.LayoutView do
  use Picty.Web, :view

  def current_user(conn) do
    Plug.Conn.get_session(conn, :current_user)
  end

  def user_logged_in(conn) do
    Plug.Conn.get_session(conn, :current_user) != nil
  end

end
