require_relative 'piece.rb'

class Board
  attr_accessor :rows

  def initialize(start = true)
    generate_board
    if start
      set_board(:red)
      set_board(:black)
    end
  end

  def [](pos)
    row, col = pos
    @rows[row][col]
  end

  def []=(pos,piece)
    i, j = pos
    @rows[i][j] = piece
  end

  def generate_board
    @rows = Array.new(8) { Array.new(8) }
  end

  def set_board(color)
    rows = (color == :black) ? [0, 1, 2] : [5, 6, 7]
    rows.each do |row|
      if row.odd? # row + col . odd ?
        8.times do |i|
          self[[row,i]] = Piece.new([row, i], color, self) if i % 2 != 0
        end
      else
        8.times do |i|
          self[[row,i]] = Piece.new([row, i], color, self) if i % 2 == 0
        end
      end
    end

  end

  def render
    print "    "
    (0..7).each do |n|
      print "#{n}  "
    end
    puts
    rows.each_with_index do |col, i|
      print "#{i}  "
      col.each do |pos|
        if pos.class == Piece
          print "[#{pos.symbol}]"
        else
          print "[ ]"
        end
      end
      puts
    end
  end

  def copied_board # TA: just dup???
    copy = Board.new(false)
    copy.rows.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        copy[[i,j]] = self[[i, j]].dup unless self[[i, j]].nil?
      end
    end
    copy
  end

  def perform_moves(start, args)
    copy = copied_board
    args.each do |move|
      if copy[start].valid_slide?(move)
        copy[start].perform_slide(move)
        break
      elsif copy[start].valid_jump?(move)
        copy[start].perform_jump(move)
      else
        raise "InvalidMoveError"
      end
    end
    copy
  end

end
