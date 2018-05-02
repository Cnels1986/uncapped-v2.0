defmodule Uncapped.UserController do
  use Uncapped.Web, :controller
  alias Uncapped.User

  def index(conn, _params) do
    users = Repo.all(Uncapped.User)
    render conn, "index.html", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(Uncapped.User, id)
    render conn, "show.html", user: user
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
     changeset = User.changeset(%User{}, user_params)
     case Repo.insert(changeset) do
       {:ok, user} ->
         conn
         |> put_flash(:info, "#{user.name} created!")
         |> redirect(to: user_path(conn, :index))
       {:error, changeset} ->
         render(conn, "new.html", changeset: changeset)
     end
   end
end
