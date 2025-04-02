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
end
