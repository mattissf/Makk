require 'rubygems'
require 'spec'
require 'app/draw/grid/item'
require 'app/logic/grid.rb'
require 'examples/makk_helper'

describe Grid do
  include MakkHelper
  
  it "should be able to translate from grid position to pixel coordinates" do
    grid = Grid.new(mockScreen(:width => 20, :height => 20))

    position = Grid::Position.new(0, 0);
    grid.getTopLeft(position).should == [0, 0]
    grid.getBottomRight(position).should == [10, 10]

    position = Grid::Position.new(0, 1);
    grid.getTopLeft(position).should == [0, 10]
    grid.getBottomRight(position).should == [10, 20]

    position = Grid::Position.new(1, 0);
    grid.getTopLeft(position).should == [10, 0]
    grid.getBottomRight(position).should == [20, 10]   
    
    position = Grid::Position.new(1, 1);
    grid.getTopLeft(position).should == [10, 10]
    grid.getBottomRight(position).should == [20, 20]
  end
  
  it "should keep track of items in the grid" do
    surface = mockScreen(:width => 20, :height => 20)
    grid = Grid.new(surface)

    item = Grid::Item.new(Grid::Position.new(0,0))
    
    grid.add(item)
    
    grid.get(item.position).should eql(item)
  end
  
  it "should be able to detect if an item is on top of another item" do
    surface = mockScreen(:width => 20, :height => 20)
    grid = Grid.new(surface)

    item = Grid::Item.new(Grid::Position.new(0,0))
    
    grid.add(item)

    movedItem = Grid::Item.new(Grid::Position.new(0,0))
    
    grid.collision?(movedItem).should == true
  end
  
  it "should keep track of item collided with" do
    surface = mockScreen(:width => 20, :height => 20)
    grid = Grid.new(surface)

    item = Grid::Item.new(Grid::Position.new(0,0))
    
    grid.add(item)

    movedItem = Grid::Item.new(Grid::Position.new(0,0))
    grid.collision?(movedItem)
    
    grid.collideItem.should === item
  end
  
  it "should not be able to collide with itself" do
    surface = mockScreen(:width => 20, :height => 20)
    grid = Grid.new(surface)

    item = Grid::Item.new(Grid::Position.new(0,0))
    
    grid.add(item)
    
    grid.collision?(item).should be_false
  end
  
  it "should be able to detect that an item is not on top of another item" do
    surface = mockScreen(:width => 20, :height => 20)
    grid = Grid.new(surface)

    item = Grid::Item.new(Grid::Position.new(0,0))
    
    grid.add(item)

    movedItem = Grid::Item.new(Grid::Position.new(1, 1))
    
    grid.collision?(movedItem).should be_false    
  end
  
  it "should be able to calculate center slot" do
    surface = mockScreen(:width => 30, :height => 30)
    grid = Grid.new(surface)
    
    grid.getCenterSlotPosition.x.should == 1    
    grid.getCenterSlotPosition.x.should == 1    
  end
  
  it "should be able to draw all items" do
    surface = mockScreen(:width => 30, :height => 30)
    grid = Grid.new(surface)
    
    position = Grid::Position.new(0,0)
    item = Grid::Item.new(position)
    
    grid.add(item)
    
    item.should_receive(:position).twice.and_return(position)
    item.should_receive(:color).once
    
    grid.draw
  end
  
  it "should be able to find a random free slot" do
    surface = mockScreen(:width => 20, :height => 10)
    grid = Grid.new(surface)

    item = Grid::Item.new(Grid::Position.new(0,0))
    
    grid.add(item)

    position = grid.getRandomFreeSlotPosition
    
    position.x.should == 1
    position.y.should == 0
  end
  
  it "should report a movable item outside left side as a collision" do
    surface = mockScreen(:width => 10, :height => 10)
    grid = Grid.new(surface)

    movedItem = Grid::Item.new(Grid::Position.new(-1,0))
    
    grid.collision?(movedItem).should == true
  end
  
  it "should report a movable item outside right side as a collision" do
    surface = mockScreen(:width => 10, :height => 10)
    grid = Grid.new(surface)
  
    movedItem = Grid::Item.new(Grid::Position.new(1,0))
    
    grid.collision?(movedItem).should == true
  end
  
  it "should report a movable item outside top side as a collision" do
    surface = mockScreen(:width => 10, :height => 10)
    grid = Grid.new(surface)
  
    movedItem = Grid::Item.new(Grid::Position.new(0,-1))
    
    grid.collision?(movedItem).should == true
  end
  
  it "should report a movable item outside bottom side as a collision" do
    surface = mockScreen(:width => 10, :height => 10)
    grid = Grid.new(surface)
  
    movedItem = Grid::Item.new(Grid::Position.new(0,1))
    
    grid.collision?(movedItem).should == true
  end
end 