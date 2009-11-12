require 'rubygems'
require 'rubygame'
require 'spec'
require 'app/draw/grid/item/movable'
require 'app/logic/grid.rb'
require 'examples/makk_helper'

describe Grid::Item::Movable do
  include MakkHelper

  def getMovable
    grid = Grid.new(mockScreen(:width => 30, :height => 30))
    
    Grid::Item::Movable.new(Grid::Position.new(1, 1))
  end
  
  it "should be able to move left" do
    movable = getMovable
    movable.moveLeft
    
    movable.position.x.should == 0
    movable.position.y.should == 1
  end

  it "should be able to move right" do
    movable = getMovable
    
    movable.moveRight
    
    movable.position.x.should == 2
    movable.position.y.should == 1
  end

  it "should be able to move up" do
    movable = getMovable
    
    movable.moveUp
    
    movable.position.x.should == 1
    movable.position.y.should == 0
  end

  it "should be able to move down" do
    movable = getMovable
    
    movable.moveDown
    
    movable.position.x.should == 1
    movable.position.y.should == 2
  end
end