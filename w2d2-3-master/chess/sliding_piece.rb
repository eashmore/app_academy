require_relative 'piece.rb'

class SlidingPiece < Piece

  def initialize(color, board)
    super
    @moved = false
  end

  def valid_moves(directions)
    @pos = @board.position_for(self)
    @result = []

    directions.each do |direction|
      1.upto(8).each do |multiplier|
        idx1 = @pos.position[0] + (direction[0] * multiplier)
        idx2 = @pos.position[1] + (direction[1] * multiplier)
        break unless idx1.between?(0,7) && idx2.between?(0,7)
        if not @board[[idx1, idx2]].occupied?
          @result <<  @board[[idx1, idx2]]
        elsif @board[[idx1, idx2]].color_of_piece != self.color
          @result <<  @board[[idx1, idx2]]
          break
        else
          break
        end
      end
    end
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

class Rook < SlidingPiece
  DIRECTIONS = [[ 0, 1], [ 1, 0], [-1, 0], [ 0,-1]]
  def initialize(color, board)
    super
    @symbol = "\u265C"
  end

  def valid_moves(directions = DIRECTIONS)
    super(directions)
  end
end

class Bishop < SlidingPiece
  DIRECTIONS = [[ 1, 1], [ 1,-1], [-1, 1], [-1,-1]]
  def initialize(color, board)
    super
    @symbol = "\u265D"
  end

  def valid_moves(directions = DIRECTIONS)
    super(directions)
  end
end

class Queen < SlidingPiece
  DIRECTIONS = [[ 1, 1], [ 1,-1], [-1, 1], [-1,-1],
                [ 0, 1], [ 1, 0], [-1, 0], [ 0,-1]]

  def initialize(color, board)
    super
    @symbol = "\u265B"
  end

  def valid_moves(directions = DIRECTIONS)
    super(directions)
  end
end
