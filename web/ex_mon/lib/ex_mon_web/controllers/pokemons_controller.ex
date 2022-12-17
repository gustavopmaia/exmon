defmodule ExMonWeb.PokemonsController do
  use ExMonWeb, :controller

  action_fallback ExMonWeb.FallbackController

  def show(conn, %{"name" => name}) do
    with {:ok, pokemon} <- ExMon.fetch_pokemon(name) do
      conn
      |> put_status(:ok)
      |> json(pokemon)
    end
  end
end
