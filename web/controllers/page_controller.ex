defmodule Picty.PageController do
  use Picty.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
