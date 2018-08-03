defmodule Vote.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :session_key, :string
      add :option, :integer
      timestamps()
    end

    create unique_index(:votes, [:session_key])
  end
end
