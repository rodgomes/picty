defmodule Picty.PageController do
  use Picty.Web, :controller

  def index(conn, _params) do

    result = FlickAPI.search("Amsterdam", "March")
    IO.puts result.body
    render conn, "index.html"
  end

end
