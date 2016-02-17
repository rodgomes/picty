defmodule Picty.PageControllerTest do
  use Picty.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "PICTY"
  end
end
