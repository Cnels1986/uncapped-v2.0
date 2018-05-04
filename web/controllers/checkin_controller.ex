defmodule Uncapped.CheckinController do
  use Uncapped.Web, :controller

  alias Uncapped.Checkin

  def index(conn, _params) do
    checkins = Repo.all(Checkin)
    render(conn, "index.html", checkins: checkins)
  end

  def new(conn, _params) do
    changeset = Checkin.changeset(%Checkin{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"checkin" => checkin_params}) do
    changeset = Checkin.changeset(%Checkin{}, checkin_params)

    case Repo.insert(changeset) do
      {:ok, checkin} ->
        conn
        |> put_flash(:info, "Checkin created successfully.")
        |> redirect(to: checkin_path(conn, :show, checkin))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    checkin = Repo.get!(Checkin, id)
    render(conn, "show.html", checkin: checkin)
  end
end
