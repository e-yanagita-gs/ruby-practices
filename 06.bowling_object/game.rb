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
    return 0 unless @frames[index + 1]

    if frame.strike?
      bonus_of_strike(index)
    elsif frame.spare?
      bonus_of_spare(index)
    else
      0
    end
  end

  def bonus_of_strike(index)
    if @frames[index + 1].strike? && @frames[index + 2] && index < 8
      @frames[index + 1].shots.first.score + @frames[index + 2].shots.first.score
    else
      @frames[index + 1].shots.take(2).map(&:score).sum
    end
  end

  def bonus_of_spare(index)
    @frames[index + 1].shots.first.score
  end
end
