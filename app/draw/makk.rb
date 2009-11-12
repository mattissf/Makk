require 'app/draw/makk/head'
require 'app/draw/makk/body'

class Makk
  attr_reader :head
  attr_reader :tail
  
  def initialize(grid)
    @head = Makk::Head.new(grid)
    @grid = grid
    @grid.add(@head)
    
    @tail = Array.new
    
    3.times do |counter|
      bodyPart = Makk::Body.new(Grid::Position.new(@head.position.x - (counter + 1), @head.position.y))
      @grid.add(bodyPart)
      @tail << bodyPart
    end
  end
  
  def add(amount)
    amount.times do
      bodyPart = Makk::Body.new(@tail.last.position.dup)
      @grid.add(bodyPart)
      @tail << bodyPart
    end
  end
  
  def move
    nextBodyPartX = @head.position.x
    nextBodyPartY = @head.position.y

    @tail.each_index do |index|
      tempBodyPartX = @tail[index].position.x
      tempBodyPartY = @tail[index].position.y

      @tail[index].position.x = nextBodyPartX
      @tail[index].position.y = nextBodyPartY

      nextBodyPartX = tempBodyPartX
      nextBodyPartY = tempBodyPartY
    end

    @head.move
  end  
end