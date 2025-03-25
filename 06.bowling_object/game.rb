# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(input_marks)
    marks = input_marks.split(',')
    count = 0
    @frames = []
    while count < marks.size && @frames.size < 9
      if marks[count] == 'X'
        #@frames << Frame.new('X', '0')
        @frames << Frame.new('X')
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

  private

  def bonus_score(frame, index)
    return 0 unless @frames[index + 1]

    if frame.strike?
      strike_bonus(index)
    elsif frame.spare?
      spare_bonus(index)
    else
      0
    end
  end

  def strike_bonus(index)
    if @frames[index + 1].strike? && @frames[index + 2] && index < 8
      #@frames[index + 1].shots.first.score + @frames[index + 2].shots.first.score
      @frames[index + 1].score(1) + @frames[index + 2].score(1)
    else
      #@frames[index + 1].shots.take(2).map(&:score).sum
      @frames[index + 1].score(2)
    end
  end

  def spare_bonus(index)
    #@frames[index + 1].shots.first.score
    @frames[index + 1].score(1)
  end
end
