
class Player

  VERSION = "Lock, Stock and Two Smoking Barrels"

  def bet_request(game_state)
    @game_state = game_state

    current_buy_in = game_state["current_buy_in"].to_i
    minimum_raise = game_state["minimum_raise"].to_i
    minimum_raise = game_state["small_blind"] * 2 if minimum_raise == 0

    if current_player && has_two_pair?(current_player["hole_cards"] + @game_state["community_cards"])
      return (current_buy_in + minimum_raise * 2)
    end

    current_buy_in + minimum_raise
  # rescue
  #   rand(500)
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
    @current_player ||= @game_state['players'].detect { |player| player['id'] == @game_state['in_action'] }
  end
end
