require 'app/draw/grid/item/movable'

class Makk
  class Item < Grid::Item
    attr_reader :points
    
    def initialize(grid)
      @grid = grid
      @points = 4
      super(@grid.getRandomFreeSlotPosition)
    end
    
    def pickup
      @color = getRandomColor
      @position = @grid.getRandomFreeSlotPosition
    end
  end
end