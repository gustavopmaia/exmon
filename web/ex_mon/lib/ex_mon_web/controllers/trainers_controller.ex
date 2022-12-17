defmodule ExMonWeb.TrainersController do
  alias ExMonWeb.Auth.Guardian
  use ExMonWeb, :controller

  action_fallback ExMonWeb.FallbackController

  def create(conn, params) do
    with {:ok, trainer} <- ExMon.create_trainer(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(trainer) do
      conn
      |> put_status(:created)
      |> render("create.json", %{trainer: trainer, token: token})
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _trainer} <- ExMon.delete_trainer(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, trainer} <- ExMon.fetch_trainer(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", trainer: trainer)
    end
  end

  def update(conn, params) do
    with {:ok, trainer} <- ExMon.update_trainer(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", trainer: trainer)
    end
  end

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end
end
