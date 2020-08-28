defmodule LeaplyWeb.HomeLiveTest do
  use LeaplyWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Leaply can help you find it"
    assert render(page_live) =~ "Leaply can help you find it"
  end
end
