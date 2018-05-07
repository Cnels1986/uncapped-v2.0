defmodule Uncapped.Checkin do
  use Uncapped.Web, :model

  schema "checkins" do
    field :rating, :integer
    belongs_to :user, Uncapped.User, foreign_key: :user_id
    belongs_to :beer, Uncapped.Beer, foreign_key: :beer_id

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:rating, :beer_id, :user_id])
    |> validate_required([:rating])
    |> validate_number(:rating, greater_than: 0, less_than: 6)
    |> cast_assoc(:user)
  end
end
