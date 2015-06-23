require_relative 'piece.rb'

class SteppingPiece < Piece
  def initialize(color, board)
    super
    @moved = false
  end

  def valid_moves(moves)
    @pos = @board.position_for(self)
    @result = []
    moves.each do |x_diff, y_diff|
      idx1, idx2 = x_diff + @pos.position[0], y_diff + @pos.position[1]
      @result << @board[[idx1, idx2]] if idx1.between?(0,7) && idx2.between?(0,7)
    end

    @result = @result.select { |tile| !tile.occupied? || tile.color_of_piece != self.color}
    @result
  end

  def checked
    @result.reject { |tile| checked_helper(tile, self) }
  end

  def checked_helper(tile, piece)
    board_copy = @board.dup_board
    board_copy.move(piece, tile.position, @pos.position)
    board_copy.in_check?(@color)
  end
end

class King < SteppingPiece
  MOVES = [[ 1, 1],[ 0, 1],[ 1, 0],[ 1,-1],
           [-1,-1],[ 0,-1],[-1, 0],[-1, 1]]

  def initialize(color, board)
    super
    @symbol = "\u265A"
  end

  def valid_moves(moves = MOVES)
    super(moves)
  end
end

class Knight < SteppingPiece
  MOVES = [[ 2, 1],[ 1, 2],[-2,-1],[-1,-2],
           [-1, 2],[ 1,-2],[-2, 1],[ 2,-1]]

  def initialize(color, board)
    super
    @symbol = "\u265E"
  end

  def valid_moves(moves = MOVES)
    super(moves)
  end
end
