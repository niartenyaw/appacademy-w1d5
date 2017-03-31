require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_reader :fragment, :players

  def initialize(p1, p2, dict_filename = './dictionary.txt')
    @fragment = ''

    @dictionary = nil
    get_dictionary(dict_filename)
    @p1 = p1 || HumanPlayer.new
    @p2 = p2 || ComputerPlayer.new(self)
    @players = [@p1, @p2]
    @current_player = @p1
  end

  def get_dictionary(filename = '')
    return @dictionary unless @dictionary.nil?
    f = File.open(filename)
    @dictionary = f.readlines.map(&:chomp)
  end

  def switch_player!
    next_player = @current_player == @p1 ? @p2 : @p1
    @current_player = next_player
  end

  def play
    until won?
      attempt_turn
    end
    puts "#{@current_player} wins!"
    puts "\"#{@fragment}\" is a word in the dictionary!"
  end

  def hint

  end

  private

  def attempt_turn
    letter = @current_player.take_turn(fragment, players.count)
    if valid_play?(letter)
      @fragment << letter
      switch_player!
    else
      @current_player.invalid_move
    end
  end

  def valid_play?(letter)
    return false if letter.nil?
    return false if letter.length != 1
    return false if letter.ord < "a".ord || letter.ord > "z".ord
    new_fragment = @fragment + letter
    @dictionary.any? { |word| word.start_with?(new_fragment) }
  end

  def won?
    @dictionary.include?(@fragment)
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new(nil, nil)
  game.play
end
