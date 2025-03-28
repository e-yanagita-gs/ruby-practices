# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(input_text)
    marks = input_text.split(',')
    count = 0
    @frames = []
    while count < marks.size && @frames.size < 9
      is_strike = Frame.new(marks[count]).strike?
      @frames << Frame.new(*marks[count, is_strike ? 1 : 2])
      count += is_strike ? 1 : 2
    end
    @frames << Frame.new(*marks[count, 3])
  end

  def total_score
    @frames.each_with_index.sum do |frame, index|
      frame.calc_score + bonus_score(frame, index)
    end
  end

  private

  def bonus_score(frame, index)
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
