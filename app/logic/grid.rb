require 'app/logic/grid/position'
require 'app/logic/grid/slot'

class Grid
  attr_reader :collideItem
  
  def initialize(surface)
    @items = Array.new
    @surface = surface

    itemHeight = 10
    itemWidth  = 10

    @numberOfSlotsOnAxisX = surface.width / itemWidth
    @numberOfSlotsOnAxisY = surface.height / itemHeight

    @slots = Array.new(@numberOfSlotsOnAxisX) do |x_index|
      Array.new(@numberOfSlotsOnAxisY) do |y_index|
        topLeftX = x_index * itemWidth
        topLeftY = y_index * itemHeight
        topLeft = [topLeftX, topLeftY]

        bottomRightX = (x_index + 1) * itemWidth
        bottomRightY = (y_index + 1) * itemHeight
        bottomRight = [bottomRightX, bottomRightY]

        Slot.new(topLeft, bottomRight)
      end
    end
  end

  def add(item)
    @items << item
  end

  def get(position)
    @items.each do |item|
      if item.position.x == position.x and item.position.y == position.y
        return item
      end
    end
    
    return nil
  end

  def getTopLeft(position)
    return @slots[position.x][position.y].topLeft
  end

  def getBottomRight(position)
    return @slots[position.x][position.y].bottomRight
  end

  def getCenterSlotPosition
    x = (@slots.size / 2).floor
    y = (@slots[0].size / 2).floor

    return Grid::Position.new(x, y)
  end

  def collision?(movedItem)
    @collideItem = nil
    
    @items.each do |item|
      if movedItem.position.eql? item.position
        if movedItem.object_id != item.object_id
          @collideItem = item
          return true
        end
      end
    end
    
    if movedItem.position.x < 0 || movedItem.position.y < 0
      return true
    elsif movedItem.position.x >= @numberOfSlotsOnAxisX || movedItem.position.y >= @numberOfSlotsOnAxisY
      return true
    end
    
    return false
  end

  def draw
    @items.each do |item|
      @surface.draw_box_s(getTopLeft(item.position), getBottomRight(item.position), item.color)
    end
  end

  def getRandomFreeSlotPosition
    loop do
      randomPosition = Grid::Position.new(
        rand(@numberOfSlotsOnAxisX), 
        rand(@numberOfSlotsOnAxisY)
      )
      
      if get(randomPosition) == nil
        return randomPosition
      end
    end
  end
end