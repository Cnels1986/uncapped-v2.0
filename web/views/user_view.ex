defmodule Uncapped.UserView do
  use Uncapped.Web, :view
  alias Uncapped.User

  def first_name(%User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
