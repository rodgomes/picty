defmodule Picty.PageViewTest do
  use Picty.ConnCase, async: true

  import Phoenix.View

  test "renders index.html" do
    assert render_to_string(Picty.PageView, "index.html", []) =~
           "Show me some pictures"
  end


end
