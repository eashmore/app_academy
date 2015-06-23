require_relative 'board.rb'

class Game
  attr_accessor :board

  def initialize
    @board = Board.new
    @current_player = :red
  end

  def play
    until win?
      board.render
      @current_player = @current_player == :red ? :black : :red
      turn
    end
    puts "You win"
  end

  def turn
    print "Choose a piece > "
    starting_pos = gets.chomp.chars.map(&:to_i)
    print "Choose a location or location chain > "
    locations = gets.chomp.split(' ')
    locations.each_with_index do |arg, i|
      locations[i] = arg.chars.map(&:to_i)
    end
    p locations
    board.perform_moves(starting_pos, locations)
  end

  def win?
    false
  end
end


game = Game.new
game.play
