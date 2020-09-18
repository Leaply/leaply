defmodule LeaplyWeb.Admin.UserLiveTest do
  use LeaplyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Leaply.AuthFixtures

  @register_attrs %{email: "test@leap.ly", password: "password"}
  @update_attrs %{email: "updated@leap.ly"}
  @invalid_attrs %{email: nil}

  defp create_user(_) do
    %{user: user_fixture()}
  end

  describe "Index" do
    setup [:register_and_log_in_user, :create_user]

    test "lists all users", %{conn: conn, user: user} do
      {:ok, _index_live, html} = live(conn, Routes.admin_user_index_path(conn, :index))

      assert html =~ "Users"
      assert html =~ user.email
    end

    test "saves new user", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.admin_user_index_path(conn, :index))

      assert index_live |> element("a", "Register User") |> render_click() =~
               "Registering a New User"

      assert_patch(index_live, Routes.admin_user_index_path(conn, :new))

      assert index_live
             |> form("#user-form", user: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#user-form", user: @register_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.admin_user_index_path(conn, :index))

      assert html =~ "User created successfully"
      assert html =~ "test@leap.ly"
    end

    test "updates user in listing", %{conn: conn, user: user} do
      {:ok, index_live, _html} = live(conn, Routes.admin_user_index_path(conn, :index))

      assert index_live |> element("#user-#{user.id} a", "Edit") |> render_click() =~
               "Editing " <> user.email

      assert_patch(index_live, Routes.admin_user_index_path(conn, :edit, user))

      assert index_live
             |> form("#user-form", user: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#user-form", user: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.admin_user_index_path(conn, :index))

      assert html =~ "User updated successfully"
      assert html =~ "updated@leap.ly"
    end

    test "deletes user in listing", %{conn: conn, user: user} do
      {:ok, index_live, _html} = live(conn, Routes.admin_user_index_path(conn, :index))

      # TODO: Add confirmation dialog

      assert index_live |> element("#user-#{user.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#user-#{user.id}")
    end
  end

  describe "Show" do
    setup [:register_and_log_in_user, :create_user]

    test "displays user", %{conn: conn, user: user} do
      {:ok, _show_live, html} = live(conn, Routes.admin_user_show_path(conn, :show, user))

      assert html =~ "Show User"
      assert html =~ user.email
    end

    test "updates user within modal", %{conn: conn, user: user} do
      {:ok, show_live, _html} = live(conn, Routes.admin_user_show_path(conn, :show, user))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Editing " <> user.email

      assert_patch(show_live, Routes.admin_user_show_path(conn, :edit, user))

      assert show_live
             |> form("#user-form", user: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#user-form", user: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.admin_user_show_path(conn, :show, user))

      assert html =~ "User updated successfully"
      assert html =~ "updated@leap.ly"
    end
  end
end
