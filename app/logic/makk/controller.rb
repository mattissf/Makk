require 'rubygame'
require 'app/draw/makk'
require 'app/draw/makk/item'
require 'app/logic/grid'

class Makk
  class Controller
    attr_reader :grid
    attr_reader :item
    attr_reader :makk
    
    def initialize(surface)
      @grid = Grid.new(surface)
      
      @makk = Makk.new(@grid)
      
      @item = Makk::Item.new(grid)
      grid.add(@item)      
    end

    def tick
      @makk.move

      if(@grid.collision?(@makk.head))
        handleCollision(@grid.collideItem)
      else
        @grid.draw
      end
    end

    def handleCollision(collideItem)
      if collideItem.instance_of? Makk::Item
        @makk.add(collideItem.points)
        @item.pickup
        @grid.draw
      else
        gameOver
      end
    end
    
    def gameOver
      puts "You got " + ((@makk.tail.size - 3) * 10).to_s + " points."
      exit
    end
  end
end