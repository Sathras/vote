defmodule VoteWeb.PageController do
  use VoteWeb, :controller

  # plug :authenticate when action in [:edit]

  def index(conn, _params) do
    render conn, "index.html"
  end

  # defp authenticate(conn, _opts) do
  #   if conn.assigns.current_user do
  #     conn
  #   else
  #     conn
  #     |> put_flash(:error, "You must be logged in to access that page")
  #     |> redirect(to: page_path(conn, :vote))
  #     |> halt()
  #   end
  # end
end
