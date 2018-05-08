defmodule Uncapped.CheckinController do
  use Uncapped.Web, :controller

  alias Uncapped.Checkin
  alias Uncapped.Beer
  alias Uncapped.User

  def index(conn, _params) do
    checkins = Repo.all(Checkin)
    beer = Repo.all(Beer)
    render(conn, "index.html", checkins: checkins)
  end

  def new(conn, _params) do
    changeset =
      conn.assigns.current_user
        |> build_assoc(:checkins)
        |> Checkin.changeset()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"checkin" => checkin_params}) do
    changeset =
      conn.assigns.current_user
        |> build_assoc(:checkins)
        |> Checkin.changeset(checkin_params)

    case Repo.insert(changeset) do
      {:ok, checkin} ->
        conn
        |> put_flash(:info, "Checkin created successfully.")
        |> redirect(to: checkin_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def get_beer(id) do
    Repo.one(from b in Beer, where: b.id == ^id)
  end

  def get_user(id) do
    Repo.one(from u in User, where: u.id == ^id)
  end

  def show(conn, %{"id" => id}) do
    checkin = Repo.get!(Checkin, id)
    beer = get_beer(checkin.beer_id)
    user = get_user(checkin.user_id)
    render(conn, "show.html", checkin: checkin, beer: beer, user: user)
  end



end
