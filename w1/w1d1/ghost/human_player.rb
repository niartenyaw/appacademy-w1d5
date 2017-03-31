class HumanPlayer
  attr_reader :name

  def initialize
    print "Enter name: "
    @name = gets.chomp
  end

  def take_turn(fragment, player_count)
    puts "Current word: #{fragment}"
    puts "#{@name}, choose your next letter."
    gets.chomp.downcase
  end

  def invalid_move
    puts "That is not a valid move."
  end

  def to_s
    name
  end

end
