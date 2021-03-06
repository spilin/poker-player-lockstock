require 'json'
require_relative 'player'
require 'poker_ranking'



params = {
    "tournament_id" => "550d1d68cd7bd10003000003",     # Id of the current tournament

    "game_id" => "550da1cb2d909006e90004b1",           # Id of the current sit'n'go game. You can use this to link a
                                                    # sequence of game states together for logging purposes, or to
                                                    # make sure that the same strategy is played for an entire game

    "round" => 0,                                      # Index of the current round within a sit'n'go

    "bet_index" => 0,                                  # Index of the betting opportunity within a round

    "small_blind" =>  10,                              # The small blind in the current round. The big blind is twice the
                                                    #     small blind

    "current_buy_in" =>  300,                          # The amount of the largest current bet from any one player

    "pot" =>  1340,                                     # The size of the pot (sum of the player bets)

    "minimum_raise" =>  20,                           # Minimum raise amount. To raise you have to return at least =>
                                                    #     current_buy_in - players[in_action][bet] + minimum_raise

    "dealer" =>  1,                                    # The index of the player on the dealer button in this round
                                                    #     The first player is (dealer+1)%(players.length)

    "orbits" =>  7,                                    # Number of orbits completed. (The number of times the dealer
                                                    #     button returned to the same player.)

    "in_action" =>  1,                                 # The index of your player, in the players array

    "players" =>  [                                    # An array of the players. The order stays the same during the
        {                                           #     entire tournament

            "id" =>  0,                                # Id of the player (same as the index)

            "name" =>  "Albert",                       # Name specified in the tournament config

            "status" =>  "active",                     # Status of the player =>
                                                    #   - active =>  the player can make bets, and win the current pot
                                                    #   - folded =>  the player folded, and gave up interest in
                                                    #       the current pot. They can return in the next round.
                                                    #   - out =>  the player lost all chips, and is out of this sit'n'go

            "version" =>  "Default random player",     # Version identifier returned by the player

            "stack" =>  1010,                          # Amount of chips still available for the player. (Not including
                                                    #     the chips the player bet in this round.)

            "bet" =>  320                              # The amount of chips the player put into the pot
        },
        {
            "id" =>  1,                                # Your own player looks similar, with one extension.
            "name" =>  "LockStock",
            "status" =>  "active",
            "version" =>  "Default random player",
            "stack" =>  980,
            "bet" =>  20,
            "hole_cards" =>  [                         # The cards of the player. This is only visible for your own player
              {
                  "rank" =>  "10",
                  "suit" =>  "hearts"
              },
              {
                  "rank" =>  "3",
                  "suit" =>  "clubs"
              }
            ]
        },
        {
            "id" =>  2,
            "name" =>  "Chuck",
            "status" =>  "out",
            "version" =>  "Default random player",
            "stack" =>  0,
            "bet" =>  0
        }
    ],
    "community_cards" =>  [                            # Finally the array of community cards.
        # {
        #     "rank" =>  "Q",
        #     "suit" =>  "clubs"
        # },
        # {
        #     "rank" =>  "A",
        #     "suit" =>  "spades"
        # },
        # {
        #     "rank" =>  "K",
        #     "suit" =>  "hearts"
        # }
    ]
}

cards = [
  {
      "rank" =>  "4",
      "suit" =>  "spades"
  },
  {
      "rank" =>  "2",
      "suit" =>  "clubs"
  },
  {
      "rank" =>  "A",
      "suit" =>  "spades"
  },
  {
      "rank" =>  "5",
      "suit" =>  "diamonds"
  },
  {
      "rank" =>  "2",
      "suit" =>  "spades"
  }
]

# cards = cards.map { |card| "#{card["rank"]} of #{card["suit"].capitalize}" }
# cards = ['6 of Hearts','6 of Spades', '5 of Diamonds', '5 of Clubs', '2 of Clubs']

# hand = PokerRanking::Hand.new(['6 of Hearts','6 of Spades', '6 of Diamonds', '10 of Diamonds', '10 of Clubs', 'Jack of Hearts'])
#
# puts ['6 of Hearts','6 of Spades', '6 of Diamonds', '10 of Diamonds', '10 of Clubs', 'Jack of Hearts']
# puts cards.inspect
# puts hand.data

# puts '*'*10
puts PokerRanking::Hand.new(cards).data.inspect

# puts cards.inspect
# puts PokerRanking::Hand.new(cards).data
# puts PokerRanking::Hand.new(cards).data

puts Player.new.bet_request(params).to_s
