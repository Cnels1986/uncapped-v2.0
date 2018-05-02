defmodule Uncapped.BreweryTest do
  use Uncapped.ModelCase

  alias Uncapped.Brewery

  @valid_attrs %{name: "some name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Brewery.changeset(%Brewery{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Brewery.changeset(%Brewery{}, @invalid_attrs)
    refute changeset.valid?
  end
end
