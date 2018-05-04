defmodule Uncapped.Repo.Migrations.CreateCheckin do
  use Ecto.Migration

  def change do
    create table(:checkins) do
      add :rating, :integer
      add :user_id, references(:users, on_delete: :nothing)
      add :beer_id, references(:beers, on_delete: :nothing)

      timestamps()
    end

    create index(:checkins, [:user_id])
    create index(:checkins, [:beer_id])
  end
end
