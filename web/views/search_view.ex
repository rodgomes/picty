defmodule Picty.SearchView do
  use Picty.Web, :view

  def render("search.json", %{pictures: pictures}) do
    pictures
  end
end
