defmodule Uncapped.Beer do
  use Uncapped.Web, :model

  schema "beers" do
    field :name, :string
    field :type, :string
    belongs_to :brewery, Uncapped.Brewery, foreign_key: :brewery_id

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :type, :brewery_id])
    |> validate_required([:name])
    |> validate_length(:name, min: 3, max: 25)
  end
end
