require 'app/draw/grid/item'

class Grid
  class Item::Movable < Item
    def moveLeft
      @position.x = @position.x - 1
    end

    def moveRight
      @position.x = @position.x + 1
    end

    def moveUp
      @position.y = @position.y - 1
    end

    def moveDown
      @position.y = @position.y + 1
    end
  end
end