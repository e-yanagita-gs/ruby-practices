# frozen_string_literal: true

class Shot
  def initialize(input_marks)
    @input_marks = input_marks
  end

  def score
    @input_marks == 'X' ? 10 : @input_marks.to_i
  end
end
