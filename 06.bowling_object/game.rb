# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

class Game
  def initialize(input_text)
    shots = input_text.split(',').map { |mark| Shot.new(mark) }
    count = 0
    @frames = []
    while @frames.size < 9
      shots_per_frame = shots[count].strike? ? 1 : 2
      @frames << Frame.new(@frames.size, *shots[count, shots_per_frame])
      count += shots_per_frame
    end
    @frames << Frame.new(@frames.size, *shots[count..])
  end

  def calc_total_score
    @frames.sum do |frame|
      frame.calc_total_score(@frames)
    end
  end
end
