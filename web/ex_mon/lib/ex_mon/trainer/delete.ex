defmodule ExMon.Trainer.Delete do
  alias Ecto.UUID
  alias ExMon.{Repo, Trainer}

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format"}
      {:ok, uuid} -> delete(uuid)
    end
  end

  def delete(uuid) do
    case fetch_trainer(uuid) do
      nil -> {:error, "Trainer not found"}
      trainer -> Repo.delete(trainer)
    end
  end

  def fetch_trainer(uuid), do: Repo.get(Trainer, uuid)
end
