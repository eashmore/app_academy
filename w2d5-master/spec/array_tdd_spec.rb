require 'rspec'
require 'array_tdd'

describe Array do
  describe "#my_uniq" do
    let(:array) {[1,2,2,3,3]}
    it "returns an array with no identical elements" do
      expect(array.my_uniq).to eq([1,2,3])
    end


    it "should not mutate the original array" do
      expect(array.my_uniq).to_not be(array)
    end
  end

  describe "#two_sum" do
    let(:array) {[-1, 0, 2, -2, 1]}
    it "finds all pairs of positions where elements at positions sum to zero" do
      expect(array.two_sum).to eq([[0, 4], [2, 3]])
    end
  end

  describe "#my_transpose" do
    let(:array) { [[0, 1, 2], [3, 4, 5], [6, 7, 8]] }
    it "converts between the row-oriented and column-oriented representations" do
      expect(array.my_transpose).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
    end
  end

  describe "#stock_picker" do
    let(:array) { [6, 1, 0, 4, 3, 2, 5, 7, 5] }
    it "determines the best days to buy and then sell stocks" do
      expect(array.stock_picker).to eq([2, 7])
    end
  end
end
