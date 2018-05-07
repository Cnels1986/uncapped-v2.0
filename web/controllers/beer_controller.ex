defmodule Uncapped.BeerController do
  use Uncapped.Web, :controller

  alias Uncapped.Brewery
  alias Uncapped.Beer
  alias Uncapped.Checkin

  def show(conn, %{"id" => id}) do
    beer = Repo.get!(Beer, id) |> Repo.preload([:checkins])
    changeset = Checkin.changeset(%Checkin{})
    render(conn, "show.html", beer: beer, changeset: changeset)
  end

  def index(conn, _params) do
    beers = Repo.all(Beer)
    render conn, "index.html", beers: beers
  end

  def checkin(conn, %{"checkin" => checkin_params, "beer_id" => beer_id}) do
    user_id = conn.assigns.current_user.id

    changeset =
      Checkin.changeset(%Checkin{},
      checkin_params
        |> Map.put("beer_id", beer_id)
        |> Map.put("user_id", user_id))

    beer = Beer |> Repo.get(beer_id) |> Repo.preload([:checkins])

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Checkin added, enjoy.")
      |> redirect(to: checkin_path(conn, :index))
    else
      render(conn, "show.html", beer: beer, changeset: changeset)
    end
  end
end
