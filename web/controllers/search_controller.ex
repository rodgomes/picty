defmodule Picty.SearchController do
  use Picty.Web, :controller
  alias Picty.FlickrAPI

  def search(conn, params) do
    cityName = Dict.get(params, "city")
    month = Dict.get(params, "month")
  
    result = FlickrAPI.search(cityName, month)
    render conn, "search.json", %{"result" => result}
  end
end
