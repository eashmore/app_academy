require "rspec"
require "tower"

describe Tower do
  let(:tower) { Tower.new }
  describe '#valid_move?' do
    before(:each) do
      tower.make_move([0, 2])
    end
    it "makes sure selected move is valid" do
      expect(tower.valid_move?(0, 1)).to be true
    end

    it "checks that disc is not placed on a smaller disc" do
      expect(tower.valid_move?(0, 2)).to be false
    end

    it "checks that the tower is not empty" do
      expect(tower.valid_move?(1, 2)).to be false
    end
  end

  #
  describe '#make_move' do
    let(:full_tower) { Tower.new }
    before(:each) do
        full_tower.make_move([0, 2])
      end
    it "disc is moved from starting tower to selected tower" do
      expect(full_tower.tower).to eq([[2, 3], [nil, nil, nil], [1]])
    end
  end

  # describe '#win?' do
  #   let(:first_tower) {}
  #   let(:second_tower)
  #   let(:third_tower)
  #
  #   it "win is true when array is in a winning config" do
  #   end
  # end

end
