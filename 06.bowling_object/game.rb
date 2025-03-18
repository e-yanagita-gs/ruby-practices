# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(mark)
    marks = mark.split(',')
    count = 0
    @frames = []
    while count < marks.size && @frames.size < 9
      if marks[count] == 'X'
        @frames << Frame.new('X', '0')
        count += 1
      else
        @frames << Frame.new(marks[count], marks[count + 1])
        count += 2
      end
    end
    @frames << Frame.new(marks[count], marks[count + 1], marks[count + 2])
  end

  def total_score
    @frames.each_with_index.sum do |frame, index|
      frame.score + bonus_score(frame, index)
    end
  end

  def bonus_score(frame, index)
    bonus_count = if frame.strike?
                    2
                  elsif frame.spare?
                    1
                  else
                    0
                  end
    @frames[index + 1..].flat_map(&:shots).take(bonus_count).map(&:score).sum
  end
end
