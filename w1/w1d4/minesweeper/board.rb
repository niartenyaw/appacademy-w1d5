require_relative 'tile'
require 'byebug'

class Board

  def self.random_board(size = 8, bombs = 10)
    grid = Array.new(size) { Array.new(size) }

    board = Board.new(grid, bombs)
    board.populate
    board.neighbor_bomb_count
    board
  end

  def initialize(grid, bombs)
    @grid = grid
    @bombs = bombs
  end

  def render
    system("clear")
    puts "bombs left: #{bombs - flag_count}"
    puts "   #{(0...@grid.length).to_a.join(" ")}"
    @grid.each_with_index do |row, i|
      puts "#{i}  #{row.map(&:to_s).join(" ")}"
    end
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def neighbor_bomb_count
    @grid.each_with_index do |row, i|
      row.each_index do |j|
        bombs = neighbors([i, j]).count(&:bombed?)
        self[[i, j]].neighbor_bomb_count = bombs
      end
    end
  end

  def neighbors(pos)
    neighbors = []
    idx = [-1, 0, 1]
    idx.each do |i|
      curr_row = i + pos[0]
      idx.each do |j|
        curr_col = j + pos[1]
        curr_pos = [curr_row, curr_col]
        neighbors << self[curr_pos] if valid_pos?(curr_pos)
      end
    end
    neighbors
  end

  def valid_pos?(pos)
    pos.all? { |n| n.between?(0, grid.length - 1) }
  end

  def populate
    grid.each_with_index do |row, i|
      row.each_index do |j|
        self[[i, j]] = Tile.new
      end
    end
    place_bombs
  end

  def over?
    lose? || all_revealed_or_bombed?
  end

  def lose?
    @grid.flatten.any? { |tile| tile.bombed? && tile.revealed? }
  end

  def all_revealed_or_bombed?
    @grid.flatten.all? { |tile| tile.revealed? || tile.bombed? }
  end

  def flag_count
    @grid.flatten.count { |tile| tile.flagged? }
  end

  def reveal(pos)

    tile = self[pos]
    return if tile.revealed?
    tile.reveal
    return if tile.neighbor_bomb_count > 0

    cascade(pos)
  end

  def cascade(pos)
    idx = [-1, 0, 1]
    idx.each do |i|
      curr_row = i + pos[0]
      idx.each do |j|
        curr_col = j + pos[1]
        curr_pos = [curr_row, curr_col]
        reveal(curr_pos) if valid_pos?(curr_pos)
      end
      render
      sleep(0.25)
    end
  end

  def length
    @grid.length
  end

  private

  attr_reader :grid, :bombs

  def place_bombs
    bombs.times do
      while true
        x = rand(0...grid.length)
        y = rand(0...grid[0].length)
        unless self[[x, y]].bombed?
          self[[x, y]].place_bomb
          break
        end
      end
    end
  end

end
