defmodule LeaplyWeb.Admin.UserLive.FormComponent do
  use LeaplyWeb, :live_component

  alias Leaply.Auth

  @impl true
  def update(%{user: user} = assigns, socket) do
    changeset = Auth.change_user(user)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"user" => user_params}, socket) do
    validate_user(socket, socket.assigns.action, user_params)
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    save_user(socket, socket.assigns.action, user_params)
  end

  defp validate_user(socket, :new, user_params) do
    changeset =
      socket.assigns.user
      |> Auth.change_user_registration(user_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  defp validate_user(socket, :edit, user_params) do
    changeset =
      socket.assigns.user
      |> Auth.change_user(user_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  defp save_user(socket, :edit, user_params) do
    case Auth.update_user(socket.assigns.user, user_params) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> put_flash(:info, "User updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_user(socket, :new, user_params) do
    case Auth.register_user(user_params) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> put_flash(:info, "User created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
