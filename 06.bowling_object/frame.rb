# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @shots = [first_mark, second_mark, third_mark].compact
  end

  def calc_score(count_shot = @shots.size)
    @shots.take(count_shot).sum(&:score)
  end

  def strike?
    @shots.first.strike?
  end

  def spare?
    calc_score == 10 && !strike?
  end

  def calc_bonus_score(next_frame, next_next_frame, index)
    return 0 unless next_frame

    if strike?
      calc_strike_bonus(next_frame, next_next_frame, index)
    elsif spare?
      calc_spare_bonus(next_frame)
    else
      0
    end
  end

  def calc_strike_bonus(next_frame, next_next_frame, index)
    if next_frame.strike? && next_next_frame && index < 8
      next_frame.calc_score(1) + next_next_frame.calc_score(1)
    else
      next_frame.calc_score(2)
    end
  end

  def calc_spare_bonus(next_frame)
    next_frame.calc_score(1)
  end
end
