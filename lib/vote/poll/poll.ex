defmodule Vote.Poll do
  @moduledoc """
  The Poll context.
  """

  import Ecto.Query, warn: false
  alias Vote.Repo

  alias Vote.Poll.Vote

  @doc """
  Returns the list of votes.
  """
  def list_votes do
    Repo.all(from v in Vote, select: v.option)
  end

  @doc """
  Gets a single vote by session_key.
  """
  def get_vote_by_session_key(session_key) do
    Repo.get_by(Vote, session_key: session_key)
  end

  @doc """
  Creates or updates a vote for the given session_key.
  """
  def vote(params) do
    case get_vote_by_session_key(params["session_key"]) do
      nil -> %Vote{}
      vote -> vote
    end
    |> Vote.changeset(params)
    |> Repo.insert_or_update
  end

  @doc """
  Deletes all Vote.
  """
  def reset() do
    Repo.delete_all(Vote)
  end
end
