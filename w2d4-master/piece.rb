require 'colorize'

class Piece
  MOVES_DIFFS = [[1,1], [1,-1], [-1,-1], [-1,1]]
  PAWN_SYMBOL = '0'
  KING_SYMBOL = 'K'
  # JUMP_DIFFS = [[2,2], [2,-2], [-2,-2], [-2,2]]
  attr_reader :color, :board
  attr_accessor :pos, :king, :moves, :jumps, :neighbors

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
    @king = false
  end

  def multiplier
    color == :black ? -1 : 1
  end

  def symbol
    symbol = (@king ? KING_SYMBOL : PAWN_SYMBOL)
    symbol.colorize(:color => color)
  end

  def move_diffs
    (color == :black) ? MOVES_DIFFS.take(2) : MOVES_DIFFS.drop(2)
  end

  def valid_slides
    find_valid_slides(moves_diffs)
  end

  def find_valid_slides(moves_diffs)
    moves = []
    @neighbors = [] # TA: average @pos and destination pos... no more neighbors
    cur_x, cur_y = pos
    moves_diffs.each do |diff|
      new_move = [cur_x + diff[0], cur_y + diff[1]]
      neighbors << new_move
      # p neighbors
      next unless new_move.all?{ |pos| pos.between?(0,7)}
      moves << new_move if board[new_move].nil?
    end
    moves
  end

  def perform_slide(new_pos)
    if valid_slides.include?(new_pos)
      board[pos] = nil
      @pos = new_pos
      board[new_pos] = self
    else
      raise "Not a valid input!"
    end
  end

  def perform_jump(new_pos)
    valid_slides
    jump_list = valid_jumps
    if valid_jumps.include?(new_pos)
      board[pos] = nil
      @pos = new_pos
      board[new_pos] = self
      p neighbors
      jumped_piece = neighbors[jump_list.index(new_pos)]
      board[jumped_piece] = nil
    else
      raise "Not a valid input"
    end
  end

  def valid_jumps
    @jumps = []
    jump_moves = []
    neighbors.each do |neighbor|
      jump_moves << neighbor.dup
    end
    if board[jump_moves[0]].is_a?(Piece)
      jump_moves[0][0] = jump_moves[0][0] - 1 * multiplier
      jump_moves[0][1] = jump_moves[0][1] - 1 * multiplier
    else
      jump_moves[0] = nil
    end
    if board[jump_moves[1]].class == Piece
      jump_moves[1][0] = jump_moves[1][0] - 1 * multiplier
      jump_moves[1][1] = jump_moves[1][1] + 1 * multiplier
    else
      jump_moves[1] = nil
    end
    jump_moves.each_with_index do |pos, i|
      next if pos.nil?
      jump_moves[i] = nil unless pos.all?{ |val| val.between?(0,7) }
    end

    neighbors.each_with_index do |pos, i|
      neighbors[i] = nil if jump_moves[i].nil?
    end

    @neighbors = clean_neighbors
    jumps = jump_moves.reject{ |move| move.nil? }

  end

  def clean_neighbors
    neighbors.compact unless neighbors.nil?
  end

  def valid_slide?(new_pos)
    return true if valid_slides.include?(new_pos)
    false
  end

  def valid_jump?(new_pos)
    return true if valid_jumps.include?(new_pos)
    false
  end
end
