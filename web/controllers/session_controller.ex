defmodule Picty.SessionController do
  use Picty.Web, :controller

  plug :put_layout, "session.html"

  def signin(conn, _params) do
    render conn, "login.html"
  end

  def logout(conn, _params) do
    render conn, "about.html"
  end

end
