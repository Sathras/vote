defmodule VoteWeb.Auth do

  import Plug.Conn
  alias Vote.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    assign(conn, :current_user, get_session(conn, :user_id))
  end

  def login(conn, credential) do
    conn
    |> assign(:current_user, credential.id)
    |> put_session(:user_id, credential.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def login_by_email_and_pass(conn, email, given_pass) do
    case Accounts.authenticate_by_email_and_pass(email, given_pass) do
      {:ok, credential} -> {:ok, login(conn, credential)}
      {:error, :unauthorized} -> {:error, :unauthorized, conn}
      {:error, :not_found} -> {:error, :not_found, conn}
    end
  end
end