require_relative 'game'

class ComputerPlayer
  attr_reader :name

  def initialize(game, name = 'Computer')
    @name = name
    @hash_letters = possible_letters(game.get_dictionary)
  end

  def take_turn(fragment, player_count)
    determine_optimal_move(fragment, player_count)
  end

  def to_s
    name
  end

  def invalid_move; end

  private

  def determine_optimal_move(fragment, player_count)
    reduce_hash!(fragment, player_count)
    best_win_proportion(player_count)
  end

  def possible_letters(remainders)
    letters = Hash.new { [] }
    remainders.each do |re|
      letters[re[0]] << re[1..-1]
    end
    letters
  end

  def best_win_proportion(player_count)
    best = ''
    @hash_letters.reduce(0) do |max, k, v|
      win_prop = winning_scenarios(v, player_count)
      if win_prop > max
        best = k
        win_prop
      else
        max
      end
    end
    best
  end

  def winning_prop(letters, player_count)
    winning_num = letters[k].count { |chars| (chars % player_count) > 0 }
    winning_num.to_f / player_count.to_f
  end

  def reduce_hash!(fragment, player_count)
    added = fragment[-(player_count - 1)..-1]
    new_endings = filter_endings(@hash_letters[added[0]], added[1..-1])
    @hash_letters = possible_letters(new_endings)
  end

  def filter_endings(endings, added)
    endings.select { |word| word.start_with?(added) }
  end
end
