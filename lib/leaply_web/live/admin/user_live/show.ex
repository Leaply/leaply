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
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user, Auth.get_user!(id))}
  end

  defp page_title(:show), do: "Show User"
  defp page_title(:edit), do: "Edit User"
end
