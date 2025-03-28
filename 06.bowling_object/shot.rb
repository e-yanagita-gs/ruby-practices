# frozen_string_literal: true

class Shot
  def initialize(input_text)
    @input_text = input_text
  end

  def score
    @input_text == 'X' ? 10 : @input_text.to_i
  end
end
