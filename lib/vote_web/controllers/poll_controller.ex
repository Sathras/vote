defmodule VoteWeb.PollController do
  use VoteWeb, :controller

  alias Vote.Poll

  # plug :authenticate when action in [:edit]

  def home(conn, _params) do
    case Poll.get_vote_by_session_key(session_key(conn)) do
      nil -> redirect conn, to: poll_path(conn, :new)
      _vote -> redirect conn, to: poll_path(conn, :index)
    end    
  end

  def create(conn, params) do
    # create or update vote
    case Poll.vote(Map.put(params, "session_key", session_key(conn))) do
      {:ok, _vote} ->
        conn
        |> put_flash(:info, "Thank you for your vote!")
        |> redirect(to: poll_path(conn, :index))

      {:error, _changeset} ->
        conn
        |> put_flash(:info, "Something went wrong!")
        |> render("new.html")
    end
  end

  def index(conn, _params) do
    render conn, "index.html", votes: Poll.list_votes()
  end

  def new(conn, _params) do
    selected = case Poll.get_vote_by_session_key(session_key(conn)) do
      nil -> nil
      vote -> vote.option
    end
    render conn, "new.html", selected: selected
  end

  defp session_key(conn), do: Map.get(conn.req_cookies, "_vote_key")

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
