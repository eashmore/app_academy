require_relative 'stepping_piece.rb'
require_relative 'sliding_piece.rb'
require_relative 'pawn.rb'
require 'colorize'

class Board
  attr_accessor :grid

  def initialize(new_board = true)
    generate_board
    if new_board
      set_board
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def piece_at(pos)
    self[pos].piece
  end

  def position_for(piece)
    8.times do |idx1|
      8.times do |idx2|
        temp_tile = @grid[idx1][idx2]
        return temp_tile if temp_tile.piece == piece
      end
    end
    nil
  end

  def king(color)
    self.flatten.each do |tile|
      return tile if tile.piece.is_a?(King) && tile.piece.color == color
    end
  end

  def checkmate?(color)
    opponent_color = color == :red ? :black : :red
    opponent_tiles = tiles_for(opponent_color)

    opponent_tiles.each do |tile|
      tile.piece.valid_moves
      next if tile.piece.checked.nil?
      return false unless tile.piece.checked.empty?
    end

    true
  end

  def dup_board
    board_copy = Board.new(false)
    board_copy.grid.each_with_index do |row, idx1|
      row.each_with_index do |tile, idx2|
        tile = Tile.new(self[[idx1,idx2]].position)
        if self[[idx1,idx2]].occupied?
          type = self[[idx1,idx2]].piece.class
          piece = type.new(self[[idx1,idx2]].piece.color, board_copy)
          board_copy[[idx1,idx2]].set_tile_to_piece(piece)
        end
      end
    end
    board_copy
  end

  def tiles_for(color)
    tiles = []
    self.flatten.each do |tile|
      tiles << tile if tile.occupied? && tile.piece.color == color
    end
    tiles
  end

  def in_check?(color)
    opponent_color = color == :red ? :black : :red
    opponent_tiles = tiles_for(opponent_color)

    opponent_tiles.each do |tile|
      valid_moves = tile.piece.valid_moves
      next if valid_moves.empty?
      return true if valid_moves.include?(king(color))
    end

    false
  end

  def flatten
    @grid.flatten
  end

  def move(piece, pos, old_pos)
    place_piece(piece, pos)
    set_position_empty(old_pos)
    piece.moved = true
  end

  def place_piece(piece, pos)
    self[pos].set_tile_to_piece(piece)
  end

  def set_board
    8.times do |idx2|
      place_piece(Pawn.new(:red, self), [1,idx2])
      place_piece(Pawn.new(:black, self), [6,idx2])
    end

    players = {:red => 0, :black => 7 }
    players.each do |color, row|
      place_piece(Rook.new(color, self), [row,0])
      place_piece(Rook.new(color, self), [row,7])

      place_piece(Knight.new(color, self), [row,1])
      place_piece(Knight.new(color, self), [row,6])

      place_piece(Bishop.new(color, self), [row,2])
      place_piece(Bishop.new(color, self), [row,5])

      place_piece(King.new(color, self), [row,4])
      place_piece(Queen.new(color, self), [row,3])
    end
  end


  def set_position_empty(pos)
    self[pos].set_tile_to_empty
  end

  def render
    print " "
    ('a'..'h').each do |letter|
      print "  #{letter}".cyan
    end
    puts
    @grid.each_with_index do |row, i|
      print "#{i} ".cyan
      row.each do |tile|
        print tile.inspect
      end
      puts
    end

    nil
  end

  private

  def generate_board
    @grid = Array.new(8) do |row|
      Array.new(8) { |col| Tile.new([row, col]) }
    end
  end
end

class Tile
  attr_reader :piece
  attr_accessor :position

  def initialize(position)
    @position = position
    @piece = nil
  end

  def set_tile_to_piece(piece)
    @piece = piece
  end

  def set_tile_to_empty
    @piece = nil
  end

  def color_of_piece
    @piece.color
  end

  def occupied?
    !@piece.nil?
  end

  def bg_color
    color_eval = @position[0] + @position[1]
    return :light_white if color_eval.even?
    :light_black
  end

  def inspect
    unless @piece == nil
      " #{@piece.symbol} ".colorize(:color => @piece.color,
                                    :background => bg_color)
    else
      "   ".colorize(:background => bg_color)
    end
  end
end
