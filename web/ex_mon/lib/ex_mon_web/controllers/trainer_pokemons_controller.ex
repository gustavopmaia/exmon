defmodule ExMonWeb.TrainerPokemonsController do
  use ExMonWeb, :controller

  action_fallback ExMonWeb.FallbackController

  def create(conn, params) do
    with {:ok, pokemon} <- ExMon.create_trainer_pokemon(params) do
      conn
      |> put_status(:created)
      |> render("create.json", pokemon: pokemon)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, pokemon} <- ExMon.fetch_trainer_pokemon(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", pokemon: pokemon)
    end
  end

  def update(conn, params) do
    with {:ok, pokemon} <- ExMon.update_trainer_pokemon(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", pokemon: pokemon)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _pokemon} <- ExMon.delete_trainer_pokemon(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end
end
