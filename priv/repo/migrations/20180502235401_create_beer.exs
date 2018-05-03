defmodule Uncapped.Repo.Migrations.CreateBeer do
  use Ecto.Migration

  def change do
    create table(:beers) do
      add :name, :string
      add :brewery_id, references(:breweries, on_delete: :delete_all)

      timestamps()
    end

    create index(:beers, [:brewery_id])
  end
end
