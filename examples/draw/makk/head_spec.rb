require 'rubygems'
require 'rubygame'
require 'spec'
require 'app/draw/makk/head'
require 'app/logic/grid.rb'
require 'examples/makk_helper'

describe Makk::Head do
  include MakkHelper

  it "should spawn in center of screen" do
    grid = Grid.new(mockScreen(:width => 30, :height => 30))
    makkHead = Makk::Head.new(grid)

    makkHead.position.x.should == 1
    makkHead.position.y.should == 1
  end

  it "should be able to move left" do
    grid = Grid.new(mockScreen(:width => 30, :height => 30))
    makkHead = Makk::Head.new(grid)
    
    makkHead.goUp
    makkHead.move
    
    makkHead.goLeft
    
    makkHead.should_receive(:moveLeft).once
    
    makkHead.move    
  end

  it "should be able to move right" do
    grid = Grid.new(mockScreen(:width => 30, :height => 30))
    makkHead = Makk::Head.new(grid)
    
    makkHead.goRight
    
    makkHead.should_receive(:moveRight).once
    
    makkHead.move
  end

  it "should be able to move up" do
    grid = Grid.new(mockScreen(:width => 30, :height => 30))
    makkHead = Makk::Head.new(grid)
    
    makkHead.goUp
    
    makkHead.should_receive(:moveUp).once
    
    makkHead.move
  end

  it "should be able to move down" do
    grid = Grid.new(mockScreen(:width => 30, :height => 30))
    makkHead = Makk::Head.new(grid)
    
    makkHead.goDown
    
    makkHead.should_receive(:moveDown).once
    
    makkHead.move
  end

  it "should start moving right" do
    grid = Grid.new(mockScreen(:width => 30, :height => 30))
    makkHead = Makk::Head.new(grid)

    makkHead.should_receive(:moveRight).once
        
    makkHead.move
  end
  
  it "should not be able to move up when moving down" do
    grid = Grid.new(mockScreen(:width => 30, :height => 30))
    makkHead = Makk::Head.new(grid)
    
    makkHead.direction = :down
    makkHead.move
    
    makkHead.goUp
    makkHead.should_receive(:moveDown)
    makkHead.move
  end
  
  it "should not be able to move down when moving up" do
    grid = Grid.new(mockScreen(:width => 30, :height => 30))
    makkHead = Makk::Head.new(grid)

    makkHead.direction = :up
    makkHead.move
    
    makkHead.goDown
    makkHead.should_receive(:moveUp)
    makkHead.move
  end
  
  it "should not be able to move right when moving left" do
    grid = Grid.new(mockScreen(:width => 30, :height => 30))
    makkHead = Makk::Head.new(grid)
    
    makkHead.direction = :left
    makkHead.move
    
    makkHead.goRight
    makkHead.should_receive(:moveLeft)
    makkHead.move
  end
  
  it "should not be able to move left when moving right" do
    grid = Grid.new(mockScreen(:width => 30, :height => 30))
    makkHead = Makk::Head.new(grid)

    makkHead.direction = :right
    makkHead.goLeft
    makkHead.should_receive(:moveRight)
    
    makkHead.move
  end
end