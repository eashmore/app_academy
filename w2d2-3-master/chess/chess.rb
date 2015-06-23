require_relative 'player.rb'
require_relative 'board.rb'

class ChessGame
  def initialize
    @board = Board.new
  end

  def play
    loop do
      round(:black)
      if @board.checkmate?(:black)
        puts "Checkmate! Black wins"
        break
      end
      puts "You're in check." if @board.in_check?(:red)
      round(:red)
      if @board.checkmate?(:red)
        puts "Checkmate! Red wins"
        break
      end
      puts "You're in check." if @board.in_check?(:black)
    end
  end

  def round(color)
    @board.render
    begin
    puts "#{color}'s turn"
      puts "Enter the coordinates of the piece you'd like to move: "
      move_from  = input_parser(gets.chomp.chars.reverse)

      piece = @board.piece_at(move_from)
      raise if piece.color != color
      puts "Enter where you'd like to move this piece: "
      move_to = input_parser(gets.chomp.chars.reverse)

      piece.valid_moves
      included = piece.checked.include?(@board[move_to])

      if included
        @board.move(piece, move_to, move_from)
      else
        raise
      end

    rescue
      puts "Invalid input, try again"
      retry
    end
  end

  def input_parser(input)
    letter_mapper = ('a'..'h').to_a
    input[1] = letter_mapper.index(input[1])
    input.map(&:to_i)
  end
end

game = ChessGame.new
game.play
