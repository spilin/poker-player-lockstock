
class Player

  VERSION = "Default Ruby folding player"

  def bet_request(game_state)
    game_state["minimum_raise"] * 2

  rescue
    rand(500)
  end

  def showdown(game_state)

  end
end
