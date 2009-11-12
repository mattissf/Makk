require 'rubygems'
require 'rubygame'
require 'app/draw/makk/head'
require 'app/logic/makk/controller'

class Makk
  class Main
    include Rubygame
    def initialize
      @width  = 300
      @height = 300

      @screen = Screen.new [@width, @height]

      @events = EventQueue.new
      @clock = Clock.new
      @clock.target_framerate = 10

      @controller = Makk::Controller.new(@screen)

      start_game
    end

    def start_game
      loop do
        @events.each do |event|
          case event
          when QuitEvent
            return
          when KeyDownEvent
            @controller.makk.head.handleKeyEvent event
          end
        end

        @screen.fill [0, 0, 0]
        @controller.tick
        @screen.update
        @clock.tick
      end
    end
  end
end

Makk::Main.new