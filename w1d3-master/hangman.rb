class HumanPlayer
  attr_reader :secret_word
  def initialize
    @secret_word = nil
    @secret_word_length = nil
  end

  def pick_secret_word
    puts "How long is your word?"
    @secret_word_length = Integer(gets)
    receive_secret_length
  end

  def receive_secret_length
    @secret_word = ("_ " * @secret_word_length).strip
  end

  def guess
    puts "what would you like to guess?"
    letter = gets.chomp
    return guess if letter.length > 1 || !('a'..'z').include?(letter)
    puts "OK, your guess is #{letter}"
    letter
  end

  def check_guess(letter)
    puts "Is #{letter} in your word?"
    puts "Y/N"
    response = gets.chomp.upcase
    handle_guess_response(letter, response)
  end

  def handle_guess_response(letter, response)
    if response == "Y"
      puts "What is the index of the letter?"
      idx = Integer(gets)
      temp = @secret_word.split(" ")
      temp[idx] = letter
      @secret_word = temp.join(" ")

      if !@secret_word.include?('_')
        return
      end
      puts "Is there another #{letter}? (Y/N)"
      multiple_letters = gets.chomp.upcase
      if multiple_letters == "Y"
        puts @secret_word
        handle_guess_response(letter, "Y")
      end
    end
  end
end

class ComputerPlayer

  def initialize
    @dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @secret_word = nil
    @guessed_letters = []
    @secret_word_display = nil
  end

  def pick_secret_word
    @secret_word = @dictionary.sample
    receive_secret_length
  end

  def receive_secret_length
    @secret_word_display = ("_ " * @secret_word.length).strip
  end

  def guess
    letter = nil
    loop do
      letter = ('a'..'z').to_a.sample
      if !@guessed_letters.include?(letter)
        @guessed_letters << letter
        break
      end
    end

    letter
  end

  def check_guess(letter)
    if @secret_word.include?(letter)
      puts "Yes!"
      handle_guess_response(letter)
    else
      puts "Nope!"
    end
  end

  def handle_guess_response(letter)
    temp = @secret_word_display.split(" ")
    @secret_word.each_with_index do |x,y|
      if letter == x
        temp[y] = x
      end
    end
    @secret_word_display = temp.join(" ")
  end
end

class Hangman

  def initialize(checking_player, guessing_player)
    @secret_word = "_"
    @guessing_player = guessing_player
    @checking_player = checking_player
    @hanged_man = nil
  end

  def play
    @checking_player.pick_secret_word
    puts "So we are ready!"
    puts
    puts "Here is the secret word"
    #puts @checking_player.receive_secret_length
    loop do
      @secret_word = @checking_player.secret_word
      print_word
      if win?
        puts "You lost to a computer"
        break
      end
      letter = @guessing_player.guess
      @checking_player.check_guess(letter)

    end
  end

  def win?
    !@secret_word.include?('_')
  end

  def print_word
    puts @secret_word
  end
end

h = HumanPlayer.new
c = ComputerPlayer.new
game = Hangman.new(h,c)
game.play
