class Grid
  class Position
    attr_accessor :x
    attr_accessor :y
    def initialize(x, y)
      @x = x
      @y = y
    end

    def eql?(position)
      if @x == position.x && @y == position.y
        return true
      else
        return false
      end
    end
  end
end