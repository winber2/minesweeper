require_relative "board"
require_relative "tile"
require 'byebug'

class Game
  def initialize(board = Board.new)
    @board = board
    @board.generate_bombs
    @board.generate_values
  end

  def play
    @board.render
    until @board.won?
      pos = get_pos
      move = get_move
      check_move(move,pos)
      if @board[pos].bomb && @board[pos].revealed
        puts "Bomb! You lose."
        break
      end
      @board.render
    end
    puts "Game over"
  end

  def check_move(move, pos)
    if move == "r"
      if @board[pos].value == 0
        @board.tiles_to_reveal(pos)
        @board[pos].reveal
      else
        @board[pos].reveal
      end
    elsif move == "f"
      @board[pos].toggle_flag
    else
      puts "Please input either r or f"
    end
  end

  def get_pos
    print "What is your move? e.g. 4,4: "
    gets.chomp.split(",").map(&:to_i)
  end

  def get_move
    print "Move: Reveal (R) or Flag (F) "
    gets.chomp.downcase[0]
  end

end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
