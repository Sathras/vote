defmodule VoteWeb.AuthController do

  use VoteWeb, :controller

  def create(conn, %{"email" => email, "password" => pass }) do
    case VoteWeb.Auth.login_by_email_and_pass(conn, email, pass) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: poll_path(conn, :index))

      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> redirect(to: poll_path(conn, :index))
    end
  end
  
  def delete(conn, _params) do
    conn
    |> VoteWeb.Auth.logout()
    |> redirect(to: poll_path(conn, :index))
  end
end