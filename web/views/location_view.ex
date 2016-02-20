defmodule Picty.LocationView do
  use Picty.Web, :view

  def render("locations.json", %{"result" =>result}) do
    result
  end
  
end
