defmodule Uncapped.BeerController do
  use Uncapped.Web, :controller

  alias Uncapped.Brewery
  alias Uncapped.Beer

  def show(conn, %{"id" => id}) do
    beer = Repo.get!(Beer, id)
    render(conn, "show.html", beer: beer)
  end

  def index(conn, _params) do
    beers = Repo.all(Beer)
    render conn, "index.html", beers: beers
  end

end
