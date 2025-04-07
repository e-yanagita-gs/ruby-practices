# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

class Game
  def initialize(input_text)
    shots = input_text.split(',').map { |mark| Shot.new(mark) }
    count = 0
    frame_index = 0
    @frames = []
    while count < shots.size && @frames.size < 9
      shots_per_frame = shots[count].strike? ? 1 : 2
      @frames << Frame.new(frame_index, *shots[count, shots_per_frame])
      frame_index += 1
      count += shots_per_frame
    end
    @frames << Frame.new(frame_index, *shots[count..])
  end

  def calc_total_score
    @frames.sum do |frame|
      next_frame = @frames[frame.frame_index + 1]
      after_next_frame = @frames[frame.frame_index + 2]
      frame.calc_total_score(next_frame, after_next_frame)
    end
  end
end
