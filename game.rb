require_relative "board"
require_relative "tile"
require 'yaml'
require 'colorize'

class Game
  attr_accessor :board

  def self.load_file
    file = YAML::load_file('save.yml')
  end

  def initialize(board = Board.new)
    @board = board
  end

  def play
    @board.render

    until @board.won? || @board.lose?
      pos = get_pos
      move = get_move
      check_move(move, pos)

      @board.render
    end

    if @board.won?
      puts "You win!"
    else
      puts "Game over"
      @board.grid.each do |row|
        row.each {|tile| tile.reveal if tile.bomb}
      end
    end

    @board.render
  end

  def check_move(move, pos)
    if move == "r"
      if @board[pos].value == 0
        @board.tiles_to_reveal(pos)
      end
      @board[pos].reveal
    elsif move == "f"
      @board[pos].toggle_flag
    else
      puts "Please input either r or f"
    end
  end

  def get_pos
    print "What is your move? e.g. 4,4: "
    input = gets.chomp
    save if input == "save"
    input.split(",").map(&:to_i)
  end

  def get_move
    print "Move: Reveal (R) or Flag (F) "
    input = gets.chomp
    save if input == "save"
    input.downcase[0]
  end

  def save
    File.open('save.yml', 'w') {|f| f.write(@board.to_yaml)}
    puts "File saved."
    exit
  end

end

if __FILE__ == $PROGRAM_NAME
  print "Continue previous game? (Y/N) "
  input = gets.chomp.downcase
  if input == "n"
    game = Game.new
    game.board.generate_bombs
    game.board.generate_values
    game.play
  elsif input == "y"
    Game.new(Game.load_file).play
  end
end
