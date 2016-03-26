  def has_two_pair?(cards)
    ranks = cards.map { |card| card["rank"] }

    ranks.uniq.count != ranks.count
  end

cards = [
        {
            "rank" => "4",
            "suit" => "spades"
        },
        {
            "rank" => "A",
            "suit" => "hearts"
        },
        {
            "rank" => "6",
            "suit" => "clubs"
        }
    ]

puts "#{has_two_pair?(cards)} = false"


cards = [
        {
            "rank" => "4",
            "suit" => "spades"
        },
        {
            "rank" => "A",
            "suit" => "hearts"
        },
        {
            "rank" => "A",
            "suit" => "clubs"
        }
    ]

puts "#{has_two_pair?(cards)} = true"