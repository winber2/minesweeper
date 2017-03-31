# bomb?
# flag?
# revealed?
# value

class Tile
  attr_accessor :bomb, :flag, :revealed, :value

  COLORS = {
    0 => :default,
    1 => :light_blue,
    2 => :green,
    3 => :red,
    4 => :blue,
    5 => :magenta,
    6 => :cyan,
    7 => :yellow,
    8 => :light_red,
    9 => :black
  }

  def initialize(bomb = false, value = 0)
    @bomb = bomb
    @flag = false
    @revealed = false
    @value = value
  end

  def reveal
    @revealed = true
    @flag = false
  end

  def toggle_flag
    @flag = @flag == true ? false : true
  end

  def place_bomb
    @bomb = true
  end

  def to_s
    return "F" if @flag
    @revealed == false ? "*" : "#{@value.to_s.colorize(COLORS[@value])}"
  end

end
