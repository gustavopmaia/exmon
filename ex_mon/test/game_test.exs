defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Player, Game}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Gustavo", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Gustavo"
        },
        status: :started,
        turn: :player
      }

      player = Player.build("Gustavo", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Gustavo", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      new_state = %{
        computer: %Player{
          life: 50,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Robotinik"
        },
        player: %Player{
          life: 85,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Gustavo"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "returns the player information" do
      player = Player.build("Gustavo", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %ExMon.Player{
        life: 100,
        moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
        name: "Gustavo"
      }

      assert expected_response == Game.player()
    end
  end

  describe "turn/0" do
    test "returns the information if is the player or the computer turn" do
      player = Player.build("Gustavo", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      assert Game.turn() == :player
    end
  end

  describe "fetch_player/1" do
    test "when provided atom :player, returns the information of the player" do
      player = Player.build("Gustavo", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %ExMon.Player{
        life: 100,
        moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
        name: "Gustavo"
      }

      assert expected_response == Game.fetch_player(:player)
    end

    test "when provided the atom :computer, returns the information of the computer" do
      player = Player.build("Gustavo", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %ExMon.Player{
        life: 100,
        moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
        name: "Robotinik"
      }

      assert expected_response == Game.fetch_player(:computer)
    end
  end
end
