require 'colorize'

class Tile
  attr_reader :revealed, :bombs_around
  attr_accessor :neighbor_bomb_count

  def initialize(revealed = false, bombed = false, flagged = false)
    @revealed = revealed
    @bombed = bombed
    @flagged = flagged
    @neighbor_bomb_count = nil
  end

  def place_bomb
    @bombed = true
  end

  def reveal
    @revealed = true
  end

  def flag
    @flagged = true
  end

  def unflag
    @flagged = false
  end

  def bombed?
    @bombed
  end

  def flagged?
    @flagged
  end

  def revealed?
    @revealed
  end

  def to_s
    if revealed
      bombed? ? "*".colorize(:red) : revealed_tile_display
    else
      flagged? ? "F".colorize(:green) : " "
    end
  end

  def revealed_tile_display
    @neighbor_bomb_count == 0 ? "_" : @neighbor_bomb_count.to_s.colorize(:blue)
  end

end
