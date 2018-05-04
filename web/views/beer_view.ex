defmodule Uncapped.BeerView do
  use Uncapped.Web, :view

  alias Uncapped.Beer
  alias Uncapped.Brewery
  alias Uncapped.Repo

  # work in progress...
  # def find_brewery(%Beer{brewery_id: brewery_id}) do
  #   brewery =Repo.get(Brewery, brewery_id) |>  Repo.preload(beers)
  # end
end
