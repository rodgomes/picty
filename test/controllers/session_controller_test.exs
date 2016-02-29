defmodule Picty.SessionControllerTest do
  use Picty.ConnCase

  test "Show login screen", %{conn: conn} do
    conn = get conn, "/admin/signin/"
    assert html_response(conn, 200) =~ "Username"
    assert html_response(conn, 200) =~ "Password"
  end
end
