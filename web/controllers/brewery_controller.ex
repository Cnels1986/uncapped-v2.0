defmodule Uncapped.BreweryController do
  use Uncapped.Web, :controller

  alias Uncapped.Brewery
  alias Uncapped.Beer

  plug :scrub_params, "brewery" when action in [:create, :update]
  plug :scrub_params, "beer" when action in [:add_beer]

  def index(conn, _params) do
    breweries = Repo.all(Brewery)
    render(conn, "index.html", breweries: breweries)
  end

  def new(conn, _params) do
    changeset = Brewery.changeset(%Brewery{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"brewery" => brewery_params}) do
    changeset = Brewery.changeset(%Brewery{}, brewery_params)

    case Repo.insert(changeset) do
      {:ok, brewery} ->
        conn
        |> put_flash(:info, "Brewery created successfully.")
        |> redirect(to: brewery_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    brewery = Repo.get(Brewery, id) |> Repo.preload([:beers])
    changeset = Beer.changeset(%Beer{})
    render(conn, "show.html", brewery: brewery, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    brewery = Repo.get!(Brewery, id)
    changeset = Brewery.changeset(brewery)
    render(conn, "edit.html", brewery: brewery, changeset: changeset)
  end

  def update(conn, %{"id" => id, "brewery" => brewery_params}) do
    brewery = Repo.get!(Brewery, id)
    changeset = Brewery.changeset(brewery, brewery_params)

    case Repo.update(changeset) do
      {:ok, brewery} ->
        conn
        |> put_flash(:info, "Brewery updated successfully.")
        |> redirect(to: brewery_path(conn, :show, brewery))
      {:error, changeset} ->
        render(conn, "edit.html", brewery: brewery, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    brewery = Repo.get!(Brewery, id)

    Repo.delete!(brewery)

    conn
    |> put_flash(:info, "Brewery deleted successfully.")
    |> redirect(to: brewery_path(conn, :index))
  end

  def add_beer(conn, %{"beer" => beer_params, "brewery_id" => brewery_id}) do
    changeset = Beer.changeset(%Beer{}, Map.put(beer_params, "brewery_id", brewery_id))
    brewery = Brewery |> Repo.get(brewery_id) |> Repo.preload([:beers])

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Beer added, enjoy.")
      |> redirect(to: brewery_path(conn, :show, brewery))
    else
      render(conn, "show.html", brewery: brewery, changeset: changeset)
    end
  end
end
