require 'rspec'
require 'hand'

describe Hand do
  describe "#best_hand" do
  end

  describe "#best_hand_value" do

  end

  let(:hand) { Hand.new( [Card.new(:spades, :king), Card.new(:spades, :queen), Card.new(:spades, :jack), Card.new(:hearts, :king), Card.new(:hearts, :king)])}
  describe "#of_a_kind" do
    it "will determine if a hand contains a pair, three-of-a-kind, or four-of-a-kind" do
      expect(hand.of_a_kind?).to be true
      expect(hand.current_best_value).to be(2)
      expect(hand.current_best_hand).to be(13)
    end
  end

end
