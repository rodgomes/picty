defmodule Picty.SessionController do
  use Picty.Web, :controller


  def login(conn, _params) do
    locations = Repo.all(Location)
    suggested_location =
      cond do
        locations != [] -> Enum.random(Repo.all(Location)).name
        locations == [] -> ""
      end

    render conn, "index.html", location: suggested_location
  end

  def logout(conn, _params) do
    render conn, "about.html"
  end

end
