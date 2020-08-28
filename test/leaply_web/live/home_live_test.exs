defmodule LeaplyWeb.HomeLiveTest do
  use LeaplyWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Before they sold out"
    assert render(page_live) =~ "Before they sold out"
  end
end
