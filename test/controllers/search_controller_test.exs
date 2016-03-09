defmodule Picty.SearchControllerTest do
  use Picty.ConnCase

  test "GET /api/search.json", %{conn: conn} do
    conn = get conn, "/api/search.json?month=01&city=Amsterdam"
    response = json_response(conn, 200)
    assert length(response) == 1
    assert hd(response)["id"]  =~ "1-31"
    assert hd(response)["owner"] =~ "1-01"
    assert hd(response)["secret"] =~ "Amsterdam"
  end
end
