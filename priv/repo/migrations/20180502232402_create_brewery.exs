defmodule Uncapped.Repo.Migrations.CreateBrewery do
  use Ecto.Migration

  def change do
    create table(:breweries) do
      add :name, :string

      timestamps()
    end
  end
end
