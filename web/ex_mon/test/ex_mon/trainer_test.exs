defmodule ExMon.TrainerTest do
  use ExMon.DataCase

  alias ExMon.Trainer

  describe "changeset/1" do
    test "when all params are valid returns a valid changeset" do
      params = %{name: "Gustavo", password: "123456"}
      response = Trainer.changeset(params)

      assert %Ecto.Changeset{
               action: nil,
               changes: %{
                 name: "Gustavo",
                 password: "123456"
               },
               errors: [],
               valid?: true
             } = response
    end

    test "when there are invalid params, returns a invalid changeset" do
      params = %{password: "123456"}
      response = Trainer.changeset(params)

      assert %Ecto.Changeset{
               action: nil,
               changes: %{
                 password: "123456"
               },
               valid?: false
             } = response

      assert errors_on(response) == %{name: ["can't be blank"]}
    end
  end

  describe "build/1" do
    test "when valid params are provided, returns a valid struct" do
      params = %{name: "Gustavo", password: "123456"}
      response = Trainer.build(params)

      assert {:ok, %Trainer{name: "Gustavo", password: "123456"}} = response
    end

    test "when invalid params are provided, returns a error" do
      params = %{password: "123456"}

      {:error, response} = Trainer.build(params)

      assert %Ecto.Changeset{valid?: false} = response

      assert errors_on(response) == %{name: ["can't be blank"]}
    end
  end
end
