# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

class Game
  def initialize(input_text)
    marks = input_text.split(',')
    count = 0
    @frames = []
    while count < marks.size && @frames.size < 9
      shot = Shot.new(marks[count])
      if shot.strike?
        @frames << Frame.new(shot)
        count += 1
      else
        @frames << Frame.new(shot, Shot.new(marks[count + 1]))
        count += 2
      end
    end
    @frames << Frame.new(*marks[count..].map { |mark| Shot.new(mark) })
  end

  def calc_total_score
    @frames.each_with_index.sum do |frame, index|
      next_frame = @frames[index + 1]
      next_next_frame = @frames[index + 2]
      frame.calc_score + frame.calc_bonus_score(next_frame, next_next_frame, index)
    end
  end
end
