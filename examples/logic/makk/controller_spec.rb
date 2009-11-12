require 'rubygems'
require 'spec'
require 'app/logic/makk/controller'
require 'examples/makk_helper'

describe Makk::Controller do
  include MakkHelper

  it "should create makk" do
    controller = Makk::Controller.new(mockScreen(:width=>100, :height => 10))

    controller.makk.should be_an_instance_of(Makk)
  end

  it "should add makk to grid" do
    controller = Makk::Controller.new(mockScreen(:width=>100, :height => 10))

    controller.grid.get(Grid::Position.new(5, 0)).should be_an_instance_of(Makk::Head)
    controller.grid.get(Grid::Position.new(4, 0)).should be_an_instance_of(Makk::Body)
    controller.grid.get(Grid::Position.new(3, 0)).should be_an_instance_of(Makk::Body)
    controller.grid.get(Grid::Position.new(2, 0)).should be_an_instance_of(Makk::Body)
  end
  
  it "should tell makk to move" do
    surface = mockScreen(:width => 100, :height => 10)

    controller = Makk::Controller.new(surface)
    
    controller.makk.should_receive(:move)
    
    controller.tick
  end
  
  it "should drop item" do
    surface = mockScreen(:width => 100, :height => 10)

    controller = Makk::Controller.new(surface)

    controller.item.should be_instance_of Makk::Item
  end

  it "should handle makk crashing into itself" do
    surface = mockScreen(:width => 100, :height => 10)

    controller = Makk::Controller.new(surface)
    controller.grid.should_receive(:collision?).and_return(true)
    controller.grid.should_receive(:collideItem).and_return(controller.makk.tail.last)

    controller.should_receive(:gameOver)
    
    controller.tick
  end
  
  it "should tell makk it picked up an item" do
    surface = mockScreen(:width => 100, :height => 10)

    controller = Makk::Controller.new(surface)
    
    controller.grid.should_receive(:collision?).and_return(true)
    controller.grid.should_receive(:collideItem).and_return(controller.item)
    controller.makk.should_receive(:add).with(controller.item.points)
    
    controller.tick
  end
  
  it "should tell item that it is picked up" do
    surface = mockScreen(:width => 100, :height => 10)

    controller = Makk::Controller.new(surface)
    
    controller.grid.should_receive(:collision?).and_return(true)
    controller.grid.should_receive(:collideItem).and_return(controller.item)
    controller.item.should_receive(:pickup)
    
    controller.tick
  end
  
  it "should tell player how many points he got when exiting" do
    surface = mockScreen(:width => 100, :height => 10)

    controller = Makk::Controller.new(surface)
    controller.grid.should_receive(:collision?).and_return(true)

    controller.should_receive(:puts).with("You got 0 points.")
    controller.should_receive(:exit)
    
    controller.tick
  end
end