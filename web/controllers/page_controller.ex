defmodule Picty.PageController do
  use Picty.Web, :controller

  def index(conn, _params) do
    location = Enum.random(["Amsterdam", "Paris", "Berlin", "Prague", "London", "Rio de Janeiro"])
    render conn, "index.html", location: location
  end

  def about(conn, _params) do
    render conn, "about.html"
  end

end
