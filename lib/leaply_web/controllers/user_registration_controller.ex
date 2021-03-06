defmodule LeaplyWeb.UserRegistrationController do
  use LeaplyWeb, :controller

  alias Leaply.Auth
  alias Leaply.Auth.User
  alias LeaplyWeb.UserAuth

  def new(conn, _params) do
    changeset = Auth.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset, page_title: "Sign up")
  end

  def create(conn, %{"user" => user_params}) do
    case Auth.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Auth.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :confirm, &1)
          )

        conn
        |> put_flash(:info, "User created successfully.")
        |> UserAuth.log_in_user(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
