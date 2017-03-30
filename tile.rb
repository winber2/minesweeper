# bomb?
# flag?
# revealed?
# value

class Tile
  attr_accessor :bomb, :flag, :revealed, :value

  def initialize(bomb = false, value = 0)
    @bomb = bomb
    @flag = false
    @revealed = false
    @value = value
  end

  def reveal
    @revealed = true
  end

  def add_flag
    @flag = true
  end

  def remove_flag
    @flag = false
  end

  def place_bomb
    @bomb = true
  end

  def to_s
    return "F" if @flag
    @revealed == false ? "*" : "#{value}"
  end

end
