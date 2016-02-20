defmodule Picty.SearchView do
  use Picty.Web, :view

  def render("search.json", %{"result" =>result}) do
    result
  end

end
