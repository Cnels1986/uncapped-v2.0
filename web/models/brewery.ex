defmodule Uncapped.Brewery do
  use Uncapped.Web, :model

  schema "breweries" do
    field :name, :string
    has_many :beers, Uncapped.Beer

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 1, max: 30)
    |> unique_constraint(:name)
  end
end
