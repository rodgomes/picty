defmodule Picty.SearchController do
  use Picty.Web, :controller
  alias Picty.FlickrAPI

  def search(conn, _params) do
    result = FlickrAPI.search("Amsterdam", "March")
    # IO.puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>> sucess" <> HTTPotion.Response.success?(result)
    render conn, "search.json", result.body
  end
end
