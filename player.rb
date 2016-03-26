
class Player
  CURRENT_PLAYER_NAME = 'LockStock'

  VERSION = "Default Ruby folding player"

  def bet_request(game_state)
    @game_state = game_state
    game_state["minimum_raise"] * 2

  rescue
    rand(500)
  end

  def showdown(game_state)

  end

  private

  def current_player
    @current_player ||= @game_state['players'].detect { |player| player['name'] == CURRENT_PLAYER_NAME }
  end
end
