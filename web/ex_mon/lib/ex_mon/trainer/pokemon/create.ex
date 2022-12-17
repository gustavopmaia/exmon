defmodule ExMon.Trainer.Pokemon.Create do
  alias ExMon.PokeApi.Client
  alias ExMon.Trainer.Pokemon, as: TrainerPokemon
  alias ExMon.{Pokemon, Repo, Trainer}

  def call(%{"name" => name} = params) do
    name
    |> Client.get_pokemon()
    |> handle_response(params)
  end

  defp handle_response({:ok, body}, params) do
    body
    |> Pokemon.build()
    |> create_pokemon(params)
  end

  defp handle_response({:error, _msg} = error, _params), do: error

  defp create_pokemon(%Pokemon{name: name, weight: weight, types: types}, %{
         "nickname" => nickname,
         "trainer_id" => trainer_id
       }) do
    params = %{
      name: name,
      weight: weight,
      types: types,
      nickname: nickname,
      trainer_id: trainer_id
    }

    params
    |> TrainerPokemon.build()
    |> validate_trainer()
    |> handle_build()
  end

  defp handle_build({:ok, pokemon}), do: Repo.insert(pokemon)
  defp handle_build({:error, _reason} = error), do: error

  defp validate_trainer({:ok, %{trainer_id: trainer_id}} = params) do
    case Repo.get(Trainer, trainer_id) do
      %Trainer{} -> params
      nil -> {:error, "User not found"}
    end
  end
end
