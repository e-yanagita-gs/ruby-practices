# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @shots = [first_mark, second_mark, third_mark].compact.map { |mark| Shot.new(mark) }
  end

  def calc_score(count_shot = @shots.size)
    @shots.take(count_shot).sum(&:score)
  end

  def strike?
    @shots.first.score == 10
  end

  def spare?
    calc_score == 10 && !strike?
  end
end
