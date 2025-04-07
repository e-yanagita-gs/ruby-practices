# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

class Game
  def initialize(input_text)
    shots = input_text.split(',').map { |mark| Shot.new(mark) }
    count = 0
    @frames = []
    while count < shots.size && @frames.size < 9
      shots_per_frame = shots[count].strike? ? 1 : 2
      @frames << Frame.new(*shots[count, shots_per_frame])
      count += shots_per_frame
    end
    @frames << Frame.new(*shots[count..])
  end

  def calc_total_score
    @frames.each_with_index.sum do |frame, index|
      next_frame = @frames[index + 1]
      next_next_frame = @frames[index + 2]
      frame.calc_score + frame.calc_bonus_score(next_frame, next_next_frame, index)
    end
  end
end
