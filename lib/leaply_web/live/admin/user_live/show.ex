defmodule LeaplyWeb.Admin.UserLive.Show do
  use LeaplyWeb, :admin_live_view

  alias Leaply.Auth

  @impl true
  def mount(_params, %{"user_token" => user_token}, socket) do
    user = user_token && Auth.get_user_by_session_token(user_token)
    {:ok, assign(socket, current_user: user)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    user = Auth.get_user!(id)
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action, user))
     |> assign(:user, user)}
  end

  defp page_title(:show, user), do: "User #{user.email}"
  defp page_title(:edit, user), do: "Editing #{user.email}"
end
