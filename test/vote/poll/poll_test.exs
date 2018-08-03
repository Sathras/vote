defmodule Vote.PollTest do
  use Vote.DataCase

  alias Vote.Poll

  describe "votes" do
    alias Vote.Poll.Vote

    @valid_attrs %{user_key: "some user_key", option: 42}
    @update_attrs %{user_key: "some updated  user_key", option: 43}
    @invalid_attrs %{user_key: nil, option: nil}

    def vote_fixture(attrs \\ %{}) do
      {:ok, vote} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Poll.create_vote()

      vote
    end

    test "list_votes/0 returns all votes" do
      vote = vote_fixture()
      assert Poll.list_votes() == [vote]
    end

    test "get_vote!/1 returns the vote with given id" do
      vote = vote_fixture()
      assert Poll.get_vote!(vote.id) == vote
    end

    test "create_vote/1 with valid data creates a vote" do
      assert {:ok, %Vote{} = vote} = Poll.create_vote(@valid_attrs)
      assert vote. user_key == "some user_key"
      assert vote.option == 42
    end

    test "create_vote/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Poll.create_vote(@invalid_attrs)
    end

    test "update_vote/2 with valid data updates the vote" do
      vote = vote_fixture()
      assert {:ok, vote} = Poll.update_vote(vote, @update_attrs)
      assert %Vote{} = vote
      assert vote. user_key == "some updated user_key"
      assert vote.option == 43
    end

    test "update_vote/2 with invalid data returns error changeset" do
      vote = vote_fixture()
      assert {:error, %Ecto.Changeset{}} = Poll.update_vote(vote, @invalid_attrs)
      assert vote == Poll.get_vote!(vote.id)
    end

    test "delete_vote/1 deletes the vote" do
      vote = vote_fixture()
      assert {:ok, %Vote{}} = Poll.delete_vote(vote)
      assert_raise Ecto.NoResultsError, fn -> Poll.get_vote!(vote.id) end
    end

    test "change_vote/1 returns a vote changeset" do
      vote = vote_fixture()
      assert %Ecto.Changeset{} = Poll.change_vote(vote)
    end
  end
end
