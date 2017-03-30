require_relative "tile"

class Board
  attr_accessor :grid, :tiles

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
      return random_pos unless self[random_pos].bomb
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
    puts "  #{(0..8).to_a.join(" ")}"
    @grid.each_with_index do |row, idx|
      puts "#{idx} #{row.join(" ")}"
    end
  end

  def neighbors(pos)
    neighbors = []
    x, y = pos[0], pos[1]
    (-1..1).each do |row|
      (-1..1).each do |col|
        next if row == 0 && col == 0
        if within_range?(x + row) && within_range?(y + col)
          neighbors << [x + row, y + col]
        end
      end
    end
    neighbors
  end

  def neighbor_bombs(pos)
    neighbors(pos).select { |tile| self[tile].bomb }.size
  end

  def within_range?(num)
    num.between?(0,8)
  end

  def generate_values
    @grid.each_with_index do |row, rdx|
      row.each_with_index do |tile, cdx|
        tile.value = neighbor_bombs([rdx,cdx])
      end
    end
  end

  def won?
    @grid.flatten.reject {|tile| tile.revealed }.size == 10
  end

  def lose?
    @grid.flatten.any? {|tile| tile.bomb && tile.revealed}
  end

  def tiles_to_reveal(pos)
    return if self[pos].value != 0
    neighbors(pos).each do |tile|
      if !self[tile].revealed || self[tile].flag
        self[tile].reveal
        tiles_to_reveal(tile)
      end
    end
  end

end
