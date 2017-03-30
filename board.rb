require_relative "tile"

class Board
  attr_accessor :grid

  def self.create_grid
    @grid = Array.new(9) { Array.new(9) {Tile.new } }
  end

  def initialize(grid = Board.create_grid)
    @grid = grid
  end

  def generate_bombs(n = 10)
    n.times do
      self[random_position].place_bomb
    end
  end

  def random_position
    while true
      random_pos = [rand(9),rand(9)]
      return random_pos if self[random_pos].value == 0
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos,value)
    row, col = pos
    @grid[row][col] = value
  end

  def render
    @grid.each do |row|
      p row.map {|tile| tile.bomb }
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.generate_bombs
  board.render
end