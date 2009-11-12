class Grid
  class Slot
    attr_accessor :topLeft
    attr_accessor :bottomRight
    
    def initialize(topLeft, bottomRight)
      @topLeft = topLeft
      @bottomRight = bottomRight
    end
  end
end