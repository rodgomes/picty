defmodule Picty.PageController do
  use Picty.Web, :controller
  alias Picty.Location

  def index(conn, _params) do
    locations = Repo.all(Location)
    suggested_location =
      cond do
        locations != [] -> Enum.random(Repo.all(Location)).name
        locations == [] -> ""
      end

    render conn, "index.html", location: suggested_location
  end

  def about(conn, _params) do
    render conn, "about.html"
  end

end
