defmodule LeaplyWeb.Marketing.HomeLive do
  use LeaplyWeb, :marketing_live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Home", menu: false)}
  end

  @impl true
  def handle_event("toggle_menu", _params, %{assigns: %{menu: menu}} = socket) do
    {:noreply, assign(socket, menu: !menu)}
  end
end
