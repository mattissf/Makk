class Grid
  class Item
    attr_accessor :position
    attr_reader :color
    
    def initialize(position)
      @color = getRandomColor 
      @position = position
    end
    
    def getRandomColor
      return [
        getNonZeroRandomColorPoint,
        getNonZeroRandomColorPoint,
        getNonZeroRandomColorPoint
      ]
    end
  
    def getNonZeroRandomColorPoint
      rand(254) + 1
    end
  end
end