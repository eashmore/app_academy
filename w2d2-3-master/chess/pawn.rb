require_relative 'piece.rb'

class Pawn < Piece
  MOVES  = [[ 1, 0], [ 2, 0], [-2, 0], [-1, 0]]
  ATTACK = [[ 1, 1], [ 1,-1], [-1,-1], [-1, 1]]
  def initialize(color, board)
    super
    @symbol = "\u265F"
  end

  def valid_moves
    @pos = @board.position_for(self)
    @result = []
    valid_moves_helper(@color).each do |pos|
      idx = pos[0] + @pos.position[0]
      next unless idx.between?(0,7)
      @result << @board[[idx, @pos.position[1]]]
    end

    @result.reject!{|tile| tile.occupied?}

    valid_attack_helper(@color).each do |pos|
      idx1 = pos[0] + @pos.position[0]
      idx2 = pos[1] + @pos.position[1]
      next unless idx1.between?(0,7) && idx2.between?(0,7) && @board[[idx1, idx2]].occupied?
      @result << @board[[idx1, idx2]] unless @board[[idx1, idx2]].color_of_piece == @color
    end
    @result
  end

  def valid_moves_helper(color)
    return @moved ? MOVES.take(1) : MOVES.take(2) if color == :red
           @moved ? MOVES.drop(3) : MOVES.drop(2)
  end

  def valid_attack_helper(color)
    return ATTACK.take(2) if color == :red
           ATTACK.drop(2)
  end

  def checked
    @result.reject { |tile| checked_helper(tile, self) }
  end

  def checked_helper(tile, piece)
    board_copy = @board.dup_board
    board_copy.move(piece.dup, tile.position, @pos.position)
    board_copy.in_check?(@color)
  end
end
