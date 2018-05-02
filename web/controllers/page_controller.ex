defmodule Uncapped.PageController do
  use Uncapped.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
