defmodule Uncapped.CheckinView do
  use Uncapped.Web, :view

  import Ecto.Query
  alias Uncapped.Repo
  alias Uncapped.Beer
  alias Uncapped.User

  def get_beer(id) do
    Repo.one(from b in Beer, where: b.id == ^id)
  end

  def get_user(id) do
    Repo.one(from u in User, where: u.id == ^id)
  end
end
