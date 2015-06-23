class Tower
  attr_reader :tower

  def initialize
    build_towers
  end

  def [](pos)
    x, y = pos
    @tower[x][y]
  end

  def []=(pos, disc)
    x, y = pos
    @tower[x][y] = disc
  end

  def build_towers
    @tower = Array.new(3) { Array.new(3)}
    (0..2).each { |disc| @tower[0][disc] = disc + 1}
    nil
  end

  def valid_move?(start_tower, end_tower)
    return false if @tower[start_tower].compact.empty?
    return true if @tower[end_tower].compact.empty? || @tower[end_tower].compact.first > @tower[start_tower].compact.first
    p tower
    false
  end

  def make_move(move)
    p move
    start_tower, end_tower = move
    if valid_move?(start_tower, end_tower)
      @tower[start_tower] = @tower[start_tower].compact
      moving_disc = @tower[start_tower].shift
      @tower[end_tower] = @tower[end_tower].compact.unshift(moving_disc)
      p @tower
    end
  end

  def render
    @tower.each do |row|
      print row
      puts
    end
  end

  def play
    until win?
      # render
      move = get_input
      make_move(move)
    end
    puts "You win!"
  end

  def get_input
    p "Enter starting tower and end tower"
    input = gets.chomp.split(' ').map(&:to_i)
  end

  def win?
    [1, 2].each do |i|
      return true if @tower[i] == [1,2,3]
    end
    false
  end

end

game = Tower.new
game.play
