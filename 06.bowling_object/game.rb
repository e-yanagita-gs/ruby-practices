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
      frame.calc_score + calc_bonus_score(frame, index)
    end
  end

  private

  def calc_bonus_score(frame, index)
    return 0 unless @frames[index + 1]

    if frame.strike?
      calc_strike_bonus(index)
    elsif frame.spare?
      calc_spare_bonus(index)
    else
      0
    end
  end

  def calc_strike_bonus(index)
    if @frames[index + 1].strike? && @frames[index + 2] && index < 8
      @frames[index + 1].calc_score(1) + @frames[index + 2].calc_score(1)
    else
      @frames[index + 1].calc_score(2)
    end
  end

  def calc_spare_bonus(index)
    @frames[index + 1].calc_score(1)
  end
end
