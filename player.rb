
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
    if current_player && (community_cards.size == 0) && has_two_pair?(hole_cards)
      return (current_buy_in + minimum_raise)
    end

    if current_player && community_cards.count >= 3
      cards = (hole_cards + community_cards).map { |card| "#{card["rank"]} of #{card["suit"].capitalize}" }
      rank = PokerRanking::Hand.new(cards).data[:rank] rescue 0
      return 0 if rank == 0

      if rank > 3
        return 10000;
      end

      if rank > 0
        return (current_buy_in + minimum_raise)
      end
    end

    current_buy_in + minimum_raise
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

  private

  def current_player
    @current_player ||= @game_state['players'].detect do |player|
       (player['name'] == 'LockStock') || (player['id'] == @game_state['in_action'])
    end
  end
end
