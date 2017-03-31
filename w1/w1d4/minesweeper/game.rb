require 'byebug'
require_relative 'board'
require_relative 'tile'

class Game

  def initialize(board = Board.random_board)
    @board = board
  end

  def play_turn
    @board.render
    pos = get_pos
    action = get_action
    return if illegal_flag?(pos, action)

    if action == "r"
      @board.reveal(pos)
      @board[pos].unflag
    elsif action == "f"
      @board[pos].flagged? ? @board[pos].unflag : @board[pos].flag
    end
  end

  def illegal_flag?(pos, action)
    true if @board[pos].revealed? && action == "f"
  end

  def get_pos
    pos = nil
    until pos && valid_pos?(pos)
      begin
        puts "Enter target position (x,y)"
        pos = parse_pos(gets.chomp)
      rescue
        puts "Invalid position!"
      end
    end

    pos
  end

  def get_action
    action = nil
    until action
      begin
        puts "Enter your action (r = reveal, f = flag)"
        action = parse_action(gets.chomp)
      rescue
        puts "Not a valid action!"
      end
    end

    action
  end

  def valid_pos?(pos)
    in_bounds = pos.all? { |val| val.between?(0, @board.length) }
    return false unless in_bounds
    return confirm if @board[pos].flagged?
    true
  end

  def confirm
    puts "This square is flagged, are you sure? (y/n)"
    gets.chomp[0].casecmp("y")
  end

  def valid_action?(action)
    action == "r" || action == "f"
  end

  def parse_pos(pos)
    arr = pos.split(",").map(&:to_i)
    raise Error unless arr.length == 2
    arr
  end

  def parse_action(action)
    a = action[0].downcase
    raise Error unless valid_action?(a)
    a
  end

  def run
    play_turn until @board.over?
    @board.render
    print_outcome
  end

  def print_outcome
    unless @board.lose?
      puts "Congratulations, you won!"
    else
      puts "Game Over :("
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.run
end
