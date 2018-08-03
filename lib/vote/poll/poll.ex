defmodule Vote.Poll do
  @moduledoc """
  The Poll context.
  """

  import Ecto.Query, warn: false
  alias Vote.Repo

  alias Vote.Poll.Vote

  @doc """
  Returns the list of votes.

  ## Examples

      iex> list_votes()
      [%Vote{}, ...]

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
  Deletes a Vote.

  ## Examples

      iex> delete_vote(vote)
      {:ok, %Vote{}}

      iex> delete_vote(vote)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vote(%Vote{} = vote) do
    Repo.delete(vote)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vote changes.

  ## Examples

      iex> change_vote(vote)
      %Ecto.Changeset{source: %Vote{}}

  """
  def change_vote(%Vote{} = vote) do
    Vote.changeset(vote, %{})
  end
end
