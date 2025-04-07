# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

class Game
  def initialize(input_text)
    shots = input_text.split(',').map { |mark| Shot.new(mark) }
    count = 0
    @frames = []
    while count < shots.size && @frames.size < 9
      if shots[count].strike?
        @frames << Frame.new(shots[count])
        count += 1
      else
        @frames << Frame.new(shots[count], shots[count + 1])
        count += 2
      end
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
