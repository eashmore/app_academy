require 'rspec'
require 'deck'

describe Deck do
  let(:deck) { Deck.new }
  describe "#generate_deck" do
    it "will have 52 cards" do
      expect(deck.cards.count).to eq(52)
    end

    it "has 52 unique cards" do
      expect(deck.cards.uniq).to eq(deck.cards)
    end
  end

  describe "#draw_from_deck" do



    it "it draws a card from the top of the deck" do
      first_card = deck.cards[0]
      expect(deck.draw_from_deck).to eq(first_card)
      expect(deck.draw_from_deck).not_to eq(first_card)
    end
  end

  let(:cards) { [Card.new(:deuce, :clubs), Card.new(:three, :hearts)]}

  describe "#return_to_deck" do
    it "returns a number of cards to the bottom of the deck" do
      starting_deck = deck.cards
      expect(deck.return_to_deck(cards)).to eq(starting_deck.concat(cards))
    end
  end

  describe "#shuffle" do
    it "randomizes the order of the deck" do
      starting_deck = deck.cards
      expect(deck.shuffle).not_to eq(starting_deck)
    end
  end
end
