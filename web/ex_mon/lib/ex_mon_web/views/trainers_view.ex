defmodule ExMonWeb.TrainersView do
  use ExMonWeb, :view

  def render("create.json", %{
        trainer: %{id: id, name: name, inserted_at: inserted_at},
        token: token
      }) do
    %{
      message: "Trainer created successfully",
      trainer: %{id: id, name: name, inserted_at: inserted_at},
      token: token
    }
  end

  def render("show.json", %{
        trainer: %{
          id: id,
          name: name,
          inserted_at: inserted_at,
          updated_at: updated_at
        }
      }) do
    %{
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at,
        updated_at: updated_at
      }
    }
  end

  def render("update.json", %{
        trainer: %{id: id, name: name, inserted_at: inserted_at, updated_at: updated_at}
      }) do
    %{
      message: "Trainer updated successfully",
      trainer: %{id: id, name: name, inserted_at: inserted_at, updated_at: updated_at}
    }
  end

  def render("sign_in.json", %{token: token}) do
    %{message: "Signed in successfully", token: token}
  end
end
