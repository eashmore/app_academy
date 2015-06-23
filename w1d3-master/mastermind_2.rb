class Code
  def initialize
    @colors = %w(r g b y o p)
  end

  def random
    mastermind = []
    4.times{ mastermind << @colors.sample }
    mastermind
  end

  def parse
    guess = gets.chomp.downcase.chars
    unless guess.any?{ |color| @colors.include?(color) } && guess.length == 4
      puts "Invalid guess"
      guess = parse
    end
    guess
  end

  def exact_matches(player_guess, mastermind)
    matches = 0
    player_guess.each_with_index do |color, i|
      if color == mastermind[i]
        matches += 1
      end
    end
    matches
  end

  def near_matches(player_guess, mastermind)
    matches = 0
    temp = mastermind.dup
    player_guess.each do |color|
      if temp.include?(color)
        temp.delete_at(temp.index(color))
        matches += 1
      end
    end
    matches - exact_matches(player_guess, mastermind)
  end

  def results_of_turn(guess, mastermind)
    near_matches_str = "?" * near_matches(guess, mastermind)
    exact_matches_str = "!" * exact_matches(guess, mastermind)
    (exact_matches_str + near_matches_str + "0000")[0..3]
  end

end

class Game
  def initialize
    @code = Code.new
    @guess = []
    @mastermind = @code.random
    @number_of_turns = 10
  end

  def play
    until win? do
      if @number_of_turns == 0
        puts "You lose"
        return "Answer: #{@mastermind}"
      end
      puts "You have #{@number_of_turns} turns remaining"
      @guess = @code.parse
      print @guess
      p @mastermind

      puts "   " + results
      @number_of_turns -= 1
    end
    return "Congratulations"
  end

  def results
    @code.results_of_turn(@guess, @mastermind)
  end

  def win?
    results == "!!!!"
  end
end

p Game.new.play
