defmodule Picty.SearchControllerTest do
  use Picty.ConnCase

  test "GET /api/search.json", %{conn: conn} do
    conn = get conn, "/api/search.json?month=01&city=Amsterdam"
    response = json_response(conn, 200)
    assert length(response["photos"]["photo"]) == 1
    assert response["url"] =~ "1-31"
    assert response["url"] =~ "1-01"
    assert response["url"] =~ "Amsterdam"
  end
end
