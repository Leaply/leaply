defmodule LeaplyWeb.Marketing.HomeLive do
  use LeaplyWeb, :marketing_live_view

  alias Leaply.Auth

  def mount(_params, %{"user_token" => user_token}, socket) do
    if connected?(socket), do: Process.send_after(self(), :update, 10000)

    {:ok,
     assign(socket,
       current_user: Auth.get_user_by_session_token(user_token),
       page_title: "Home",
       menu: false,
       users: 2000 + :rand.uniform(1000),
       listings: 18,
       companies: 12,
       placements: 658
     )}
  end

  def mount(_params, _session, socket) do
    if connected?(socket), do: Process.send_after(self(), :update, 10000)

    {:ok,
     assign(socket,
       current_user: nil,
       page_title: "Home",
       menu: false,
       users: 2000 + :rand.uniform(1000),
       listings: 18,
       companies: 12,
       placements: 658
     )}
  end

  def handle_event("info_flash", _params, socket) do
    {:noreply, put_flash(socket, :info, "This is an example message")}
  end

  def handle_event("error_flash", _params, socket) do
    {:noreply, put_flash(socket, :error, "This is an example error message")}
  end

  def handle_info(:update, socket) do
    Process.send_after(self(), :update, 10000)
    {:noreply, assign(socket, :users, socket.assigns.users + :rand.uniform(10))}
  end
end
