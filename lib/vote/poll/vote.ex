defmodule Vote.Poll.Vote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "votes" do
    field :session_key, :string
    field :option, :integer
    timestamps()
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [:session_key, :option])
    |> validate_required([:session_key, :option])
    |> validate_number(:option, greater_than: 0, less_than: 5)
    |> unique_constraint(:session_key)
  end
end
