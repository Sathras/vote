defmodule Vote.Poll do
  
  import Ecto.Query, warn: false
  alias Vote.Repo
  alias Vote.Poll.Vote

  # Returns the list of votes.
  def list_votes, do: Repo.all(from v in Vote, select: v.option)

  # Gets a single vote by session_key.
  def get_vote_by_session_key(key), do: Repo.get_by(Vote, session_key: key)

  # Creates or updates a vote for the given session_key.
  def vote(params) do
    case get_vote_by_session_key(params["session_key"]) do
      nil -> %Vote{}
      vote -> vote
    end
    |> Vote.changeset(params)
    |> Repo.insert_or_update
  end

  # Deletes all Vote.
  def reset(), do: Repo.delete_all(Vote)
end
