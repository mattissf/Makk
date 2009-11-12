module MakkHelper
  class MockScreen
    attr_accessor :size, :width, :height

    def initialize(dimensions)
      @size = [dimensions[:width], dimensions[:height]]
      @width = dimensions[:width]
      @height = dimensions[:height]
    end

    def draw_box_s(argOne, argTwo, argThree)
    end
  end

  def mockScreen(dimensions)
    MockScreen.new(dimensions)
  end
end
