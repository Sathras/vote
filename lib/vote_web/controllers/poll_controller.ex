defmodule VoteWeb.PollController do
  use VoteWeb, :controller
  alias Vote.Poll

  plug :authenticate_user when action in [:delete]

  def home(conn, _params) do
    case vote(conn) do
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
    render conn, "new.html", selected: vote(conn)
  end

  def delete(conn, _params) do
    Poll.reset()
    redirect conn, to: poll_path(conn, :new)
  end

  defp session_key(conn), do: Map.get(conn.req_cookies, "_vote_key")

  defp vote(conn) do
    key = session_key(conn)
    if is_nil(key) do
      nil
    else 
      vote = Poll.get_vote_by_session_key(key)
      if is_nil(vote), do: nil, else: Map.get(vote, :option)
    end
  end
end
