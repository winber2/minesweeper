# bomb?
# flag?
# revealed?
# value

class Tile
  attr_accessor :bomb, :flag, :revealed, :value

  COLORS = {
    1: :blue
    2: :green
    3: :red
    4:  :darl
  }

  def initialize(bomb = false, value = 0)
    @bomb = bomb
    @flag = false
    @revealed = false
    @value = value
  end

  def reveal
    @revealed = true
  end

  def toggle_flag
    @flag = @flag == true ? false : true
  end

  def place_bomb
    @bomb = true
  end

  def to_s
    return "F" if @flag
    @revealed == false ? "*" : "#{value}"
  end

end
