# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(index, first_shot, second_shot = nil, third_shot = nil)
    @index = index
    @shots = [first_shot, second_shot, third_shot].compact
  end

  def calc_total_score(frames)
    next_frame, after_next_frame = frames[@index + 1, 2]
    calc_score + calc_bonus_score(next_frame, after_next_frame)
  end

  protected

  def calc_score(shot_count = @shots.size)
    @shots.take(shot_count).sum(&:score)
  end

  def strike?
    @shots.first.strike?
  end

  private

  def spare?
    calc_score == 10 && !strike?
  end

  def calc_bonus_score(next_frame, after_next_frame)
    return 0 unless next_frame

    if strike?
      calc_strike_bonus(next_frame, after_next_frame)
    elsif spare?
      calc_spare_bonus(next_frame)
    else
      0
    end
  end

  def calc_strike_bonus(next_frame, after_next_frame)
    if next_frame.strike? && after_next_frame
      next_frame.calc_score(1) + after_next_frame.calc_score(1)
    else
      next_frame.calc_score(2)
    end
  end

  def calc_spare_bonus(next_frame)
    next_frame.calc_score(1)
  end
end
