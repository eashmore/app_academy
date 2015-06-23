class Game
  attr_reader :hidden_rack, :board
  attr_accessor :guess

  COLORS = {
    # map the colors
    :red => 'R',
    :green => "G",
    :blue => "B",
    :yellow => "Y",
    :orange => "O",
    :purple => "P"
  }

  def initialize
    @hidden_rack = Code.random.join
    @board = []
    @player = Player.new
    @moves_left = 10
    @code = Code.new
  end

  def print
    @board.each do |turn|
      p turn
    end
  end

  def play
    until @moves_left == 0
      puts "You have #{@moves_left} moves left"
      self.print
      @guess = @player.move
      next unless @code.valid_code?(@guess)

      # #check to make sure only allowed colors are being used
      # @guess.chars.each do |color|
      #   if !COLORS.values.include?(color)
      #     next
      #   end
      # end

      #checks code
      evaluation = @code.evaluation(@guess, @hidden_rack)
      @board << [@guess, evaluation]
      @moves_left -= 1

      #checks for win
      return winning_screen if evaluation == "!!!!"
    end

    puts "Sorry you are out of moves!"
    puts "Answer:"
    puts @hidden_rack
  end

  def winning_screen
    puts "you win!"
    puts "Answer:"
    puts @hidden_rack
  end
end

class Code
  COLORS = %w(R O Y G B P)

  def self.random
    sequence = []
    4.times { sequence << COLORS.sample }
    sequence
  end

  def valid_code?(string)
    if string.length != 4
      puts "Your guess is not the right length"
      return false
    end

    if !string.split(//).all? { |chr| COLORS.include?(chr) }
      puts"you included characters you were not supposed to"
      return false
    end

    true
  end

  def evaluation(guess, answer)
    final_string = ''
    construct_answer_hash answer
    final_string << exact_matches(guess, answer)
    if final_string.length <= near_matches(guess)
      final_string << "?" * (near_matches(guess) - final_string.length)
    end
  end

  def construct_answer_hash(answer)
    @hash = Hash.new
    answer.each_char do |x|
      if @hash[x] == nil
        @hash[x] = 0
      else
        @hash[x] += 1
      end
    end
  end

  def exact_matches(guess, answer)
    final_string = ''

    guess.chars.each_with_index do |x,y|
      if x == answer[y]
        final_string << "!"
      end
    end

    final_string
  end

  def near_matches(guess)
    n = 0
    guess.each_char do |x|
      if @hash.values.include?(x)
       n += 1
     end
   end
   n
  end


end

class Player
  def move
    print "Choose 4 colors > "
    guess = gets.chomp.upcase
  end
end

if __FILE__ == $PROGRAM_NAME

  Game.new.play
end
