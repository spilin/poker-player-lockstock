
class Player
  CURRENT_PLAYER_NAME = 'LockStock'

  VERSION = "Lock, Stock and Two Smoking Barrels"

  def bet_request(game_state)
    @game_state = game_state
    game_state["minimum_raise"] * 2

  rescue
    rand(500)
  end

  def showdown(game_state)

  end

# [
#         {
#             "rank": "4",
#             "suit": "spades"
#         },
#         {
#             "rank": "A",
#             "suit": "hearts"
#         },
#         {
#             "rank": "6",
#             "suit": "clubs"
#         }
#     ]

  def has_two_pair?(cards)
    ranks = cards.map { |card| card["rank"] }

    ranks.uniq.count != ranks.count
  end

  private

  def current_player
    @current_player ||= @game_state['players'].detect { |player| player['name'] == CURRENT_PLAYER_NAME }
  end
end
