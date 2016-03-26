
class Player

  VERSION = "Lock, Stock and Two Smoking Barrels"

  def bet_request(game_state)
    @game_state = game_state

    current_buy_in = game_state["current_buy_in"].to_i
    minimum_raise = game_state["minimum_raise"].to_i
    minimum_raise = game_state["small_blind"] * 2 if minimum_raise == 0
    community_cards = game_state["community_cards"]
    hole_cards = []
    hole_cards = current_player["hole_cards"] if current_player

    # raise if two pairs
    if current_player && (community_cards.size == 0) && (has_two_pair?(hole_cards) || has_same_suit?(cards))
      return (current_buy_in - current_player["bet"] + minimum_raise)
    end

    if current_player && community_cards.count >= 3
      cards = (hole_cards + community_cards).map { |card| "#{card["rank"]} of #{card["suit"].capitalize}" }
      rank = PokerRanking::Hand.new(cards).data[:rank] rescue 0
      return 0 if rank == 0

      if rank > 3
        return 10000;
      end

      if rank > 0
        # current_buy_in - players[in_action][bet] + minimum_raise
        return (current_buy_in - current_player["bet"] + minimum_raise)
      end
    end

    if current_player && @game_state['current_buy_in'] > 150 && current_player["bet"] < 150 && community_cards.size == 0
      return 0
    end

    (current_buy_in - current_player["bet"] + minimum_raise)
  rescue StandardError => e
    puts '*'*100
    puts  e.inspect
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

  def has_same_suit?(cards)
    suits = cards.map { |card| card["suit"] }

    suits.uniq.count != suits.count
  end

  private

  def current_player
    @current_player ||= @game_state['players'].detect do |player|
       (player['name'] == 'LockStock') || (player['id'] == @game_state['in_action'])
    end
  end
end
