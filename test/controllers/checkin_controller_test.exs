defmodule Uncapped.CheckinControllerTest do
  use Uncapped.ConnCase

  alias Uncapped.Checkin
  @valid_attrs %{rating: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, checkin_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing checkins"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, checkin_path(conn, :new)
    assert html_response(conn, 200) =~ "New checkin"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, checkin_path(conn, :create), checkin: @valid_attrs
    checkin = Repo.get_by!(Checkin, @valid_attrs)
    assert redirected_to(conn) == checkin_path(conn, :show, checkin.id)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, checkin_path(conn, :create), checkin: @invalid_attrs
    assert html_response(conn, 200) =~ "New checkin"
  end

  test "shows chosen resource", %{conn: conn} do
    checkin = Repo.insert! %Checkin{}
    conn = get conn, checkin_path(conn, :show, checkin)
    assert html_response(conn, 200) =~ "Show checkin"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, checkin_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    checkin = Repo.insert! %Checkin{}
    conn = get conn, checkin_path(conn, :edit, checkin)
    assert html_response(conn, 200) =~ "Edit checkin"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    checkin = Repo.insert! %Checkin{}
    conn = put conn, checkin_path(conn, :update, checkin), checkin: @valid_attrs
    assert redirected_to(conn) == checkin_path(conn, :show, checkin)
    assert Repo.get_by(Checkin, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    checkin = Repo.insert! %Checkin{}
    conn = put conn, checkin_path(conn, :update, checkin), checkin: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit checkin"
  end

  test "deletes chosen resource", %{conn: conn} do
    checkin = Repo.insert! %Checkin{}
    conn = delete conn, checkin_path(conn, :delete, checkin)
    assert redirected_to(conn) == checkin_path(conn, :index)
    refute Repo.get(Checkin, checkin.id)
  end
end
