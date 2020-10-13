defmodule LeaplyWeb.Admin.UserLive.Index do
  use LeaplyWeb, :admin_live_view

  alias Leaply.Auth
  alias Leaply.Auth.User

  @impl true
  def mount(_params, %{"user_token" => user_token}, socket) do
    user = user_token && Auth.get_user_by_session_token(user_token)

    {:ok,
     socket
     |> assign(:current_user, user)
     |> assign(:users, list_users())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    user = Auth.get_user!(id)
    socket
    |> assign(:user, user)
    |> assign(:page_title, "Editing #{user.email}")
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User")
    |> assign(:user, %User{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Users")
    |> assign(:user, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user = Auth.get_user!(id)
    {:ok, _} = Auth.delete_user(user)

    {:noreply, assign(socket, :users, list_users())}
  end

  defp list_users do
    Auth.list_users()
  end
end
