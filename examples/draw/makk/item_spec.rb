require 'rubygems'
require 'rubygame'
require 'spec'
require 'app/draw/makk/item'
require 'app/logic/grid.rb'
require 'examples/makk_helper'

describe Makk::Item do
  include MakkHelper

  it "should move when picked up" do
    grid = Grid.new(mockScreen(:width => 30, :height => 30))
    item = Makk::Item.new(grid)

    item.position.x = 0
    item.position.y = 0
    
    grid.should_receive(:getRandomFreeSlotPosition).and_return Grid::Position.new(1, 1)
    
    item.pickup
    
    item.position.x.should == 1
    item.position.y.should == 1    
  end
  
  it "should change color when picked up" do
    grid = Grid.new(mockScreen(:width => 30, :height => 30))
    item = Makk::Item.new(grid)
    
    item.should_receive(:getRandomColor)
    
    item.pickup
  end
end