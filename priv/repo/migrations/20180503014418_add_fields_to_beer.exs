defmodule Uncapped.Repo.Migrations.AddFieldsToBeer do
  use Ecto.Migration

  def change do
    alter table(:beers) do
      add :type, :string
    end
  end
end
