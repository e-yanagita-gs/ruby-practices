# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(first_mark, second_mark, third_mark = nil)
    @frame = [first_mark, second_mark, third_mark].compact.map { |mark| Shot.new(mark) }
    #@first_shot = Shot.new(first_mark)
    #@second_shot = Shot.new(second_mark)
    #@third_shot = Shot.new(third_mark)
  end

=begin
  def shots
    [@first_shot, @second_shot, @third_shot].compact
  end
=end

  def score(count_shot = @frame.size)
    #@first_shot.score + @second_shot.score + @third_shot.score
    #@frame[0].score + @frame[1].score + @frame[2].score
    @frame.take(count_shot).sum(&:score)
  end

  def strike?
    #@first_shot.score == 10
    @frame.first.score == 10
  end

  def spare?
    score == 10 && !strike?
  end
end
