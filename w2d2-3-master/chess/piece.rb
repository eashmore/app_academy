class Piece
  attr_reader :symbol, :color, :pos
  attr_accessor :moved

  def initialize(color, board)
    @color = color
    @board = board
    @moved = false
    @symbol = ":)"
  end

  def valid_moves
    raise "Not yet implemented"
  end
end
