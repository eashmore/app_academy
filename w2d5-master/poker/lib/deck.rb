require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = generate_deck

  end

  def generate_deck
    full_deck = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        full_deck << Card.new(value, suit)
      end
    end
    full_deck
  end

  def draw_from_deck
    @cards.shift
  end

  def return_to_deck(array)
    @cards.concat(array)
  end

  def shuffle
    shuffled = @cards.shuffle
    shuffled
  end
end
