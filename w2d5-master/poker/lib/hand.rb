require 'deck'

class Hand
  HANDS = { pair:            0,
            two_pair:        1,
            three_of_a_kind: 2,
            straight:        3,
            flush:           4,
            full_house:      5,
            four_of_a_kind:  6,
            straight_flush:  7
            }

  attr_accessor :hand
  attr_reader :current_best_hand, :current_best_value

  def initialize(hand = [])
    @hand = hand
    @current_best_value = 0
    @current_best_hand = nil
  end

  def of_a_kind?
    hash = Hash.new(0)
    hand.each do |card|
      hash[card.card_value] += 1
    end
    type_of_kind(hash)
  end

  def type_of_kind(hash)
    # num_of_kinds = { :first => 0 }
    dups = 0
    card_value = nil
    hash.each do |key, value|
      if value > dups
        card_value = key
        dups = value
      end
    end
    return false if dups < 2
    if dups == 4 && @current_best_value < HANDS[:four_of_a_kind]
      @current_best_hand = card_value
      @current_best_value = HANDS[:four_of_a_kind]
    elsif dups == 3 && @current_best_value < HANDS[:three_of_a_kind]
      @current_best_hand = card_value
      @current_best_value = HANDS[:three_of_a_kind]
    elsif @current_best_value < HANDS[:pair]
      @current_best_hand = card_value
      @current_best_value = HANDS[:pair]
    end
    true
  end


end
