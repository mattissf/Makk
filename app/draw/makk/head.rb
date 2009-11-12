require 'app/draw/grid/item/movable'

class Makk
  class Head < Grid::Item::Movable
    attr_accessor :direction
    
    def initialize(grid)
      @direction = :right
      @originalDirection = :right

      centerPosition = grid.getCenterSlotPosition

      super(centerPosition)
    end

    def go(direction)
      case direction
        when :left
          @direction = :left unless @originalDirection == :right
        when :right
          @direction = :right unless @originalDirection == :left
        when :up
          @direction = :up unless @originalDirection == :down
        when :down
          @direction = :down unless @originalDirection == :up
      end
    end
    
    def goLeft
      go :left
    end

    def goRight
      go :right
    end

    def goUp
      go :up
    end

    def goDown
      go :down
    end

    def handleKeyEvent(event)
      if event.key == Rubygame::K_UP
        goUp
      elsif event.key == Rubygame::K_DOWN
        goDown
      elsif event.key == Rubygame::K_LEFT
        goLeft
      elsif event.key == Rubygame::K_RIGHT
        goRight
      end
    end    
    
    def move
      case @direction
        when :left
          moveLeft
        when :right
          moveRight
        when :up
          moveUp
        when :down
          moveDown
      end
      
      @originalDirection = @direction
    end
  end
end