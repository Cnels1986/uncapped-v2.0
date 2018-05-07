defmodule Uncapped.CheckinTest do
  use Uncapped.ModelCase

  alias Uncapped.Checkin

  @valid_attrs %{rating: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Checkin.changeset(%Checkin{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Checkin.changeset(%Checkin{}, @invalid_attrs)
    refute changeset.valid?
  end
end
