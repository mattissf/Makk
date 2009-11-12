require 'rubygems'
require 'rubygame'
require 'spec'
require 'app/draw/makk'
require 'app/logic/grid'
require 'examples/makk_helper'

describe Makk do
  include MakkHelper

  it "should create makk head" do
    grid = Grid.new(mockScreen(:width=>100, :height => 10))
    makk = Makk::new(grid)

    makk.head.should be_an_instance_of(Makk::Head)
    makk.head.position.x.should eql(5)
  end

  it "should create tail" do
    grid = Grid::new(mockScreen(:width=>100, :height => 10))
    makk = Makk.new(grid)

    makk.tail.each do |part|
      part.should be_an_instance_of(Makk::Body)
    end
    
    makk.tail[0].position.x.should eql(4)
    makk.tail[1].position.x.should eql(3)
    makk.tail[2].position.x.should eql(2)
  end

  it "should add makk to item grid" do
    grid = Grid::new(mockScreen(:width=>100, :height => 10))
    makk = Makk.new(grid)

    grid.get(Grid::Position.new(5, 0)).should be_an_instance_of(Makk::Head)
    grid.get(Grid::Position.new(4, 0)).should be_an_instance_of(Makk::Body)
    grid.get(Grid::Position.new(3, 0)).should be_an_instance_of(Makk::Body)
    grid.get(Grid::Position.new(2, 0)).should be_an_instance_of(Makk::Body)
  end
  
  it "should be able to move makk" do
    grid = Grid::new(mockScreen(:width=>100, :height => 10))
    makk = Makk.new(grid)
    
    makk.move
    
    makk.head.position.x.should eql(6)
    makk.tail[0].position.x.should eql(5)
    makk.tail[1].position.x.should eql(4)
    makk.tail[2].position.x.should eql(3)
  end
  
  it "should be able to add tail parts" do
    grid = Grid::new(mockScreen(:width=>100, :height => 10))
    makk = Makk.new(grid)

    makk.add(1)
    
    makk.tail.size.should == 4
    makk.tail.last.position.x.should == 2
    makk.tail.last.position.y.should == 0
  end
end