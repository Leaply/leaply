defmodule LeaplyWeb.UserConfirmationController do
  use LeaplyWeb, :controller

  alias Leaply.Auth

  def new(conn, _params) do
    render(conn, "new.html", page_title: "Email confirmation")
  end

  def create(conn, %{"user" => %{"email" => email}}) do
    if user = Auth.get_user_by_email(email) do
      Auth.deliver_user_confirmation_instructions(
        user,
        &Routes.user_confirmation_url(conn, :confirm, &1)
      )
    end

    # Regardless of the outcome, show an impartial success/error message.
    conn
    |> put_flash(
      :info,
      "If your email is in our system and it has not been confirmed yet, " <>
        "you will receive an email with instructions shortly."
    )
    |> redirect(to: "/")
  end

  # Do not log in the user after confirmation to avoid a
  # leaked token giving the user access to the account.
  def confirm(conn, %{"token" => token}) do
    case Auth.confirm_user(token) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Account confirmed successfully.")
        |> redirect(to: "/")

      :error ->
        conn
        |> put_flash(:error, "Confirmation link is invalid or it has expired.")
        |> redirect(to: "/")
    end
  end
end
