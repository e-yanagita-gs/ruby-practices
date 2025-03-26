# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

class Game
  def initialize(input_marks)
    #marks = input_marks.split(',')
=begin
    @frames = marks.map { |mark| Frame.new(mark) }
    print @frames
    puts
    output_marks = @frames.map do |frame|
      frame.instance_variable_get(:@frame).map(&:score)
    end.flatten

    print output_marks
=end

=begin
  # Xを10に変換してからフレーム分け
    marks = input_marks.split(',').map { |mark| mark == 'X' ? '10' : mark }
    count = 0
    @frames = []
    while count < marks.size && @frames.size < 9
      if marks[count] == '10'
        @frames << Frame.new('10')
        count += 1
      else
        @frames << Frame.new(marks[count], marks[count + 1])
        count += 2
      end
    end
    @frames << Frame.new(marks[count], marks[count + 1], marks[count + 2]
=end

  # Xそのままでフレーム分け
    marks = input_marks.split(',')
    count = 0
    @frames = []
    while count < marks.size && @frames.size < 9
      #if marks[count] == 'X'
      if Shot.new(marks[count]).score == 10
        puts "X:#{Shot.new(marks[count]).score}"
        #@frames << Frame.new('X')
        @frames << Frame.new(10)
        count += 1
      else
        puts marks[count]
        puts "Shot,new(marks[count]).score: #{Shot.new(marks[count]).score}"
        @frames << Frame.new(marks[count], marks[count + 1])
        count += 2
      end
    end
    @frames << Frame.new(marks[count], marks[count + 1], marks[count + 2])
  end

  def total_score
    @frames.each_with_index.sum do |frame, index|
      #frame.score + bonus_score(frame, index)
      frame.calc_score + bonus_score(frame, index)
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
      #@frames[index + 1].score(1) + @frames[index + 2].score(1)
      @frames[index + 1].calc_score(1) + @frames[index + 2].calc_score(1)
    else
      #@frames[index + 1].shots.take(2).map(&:score).sum
      #@frames[index + 1].score(2)
      @frames[index + 1].calc_score(2)
    end
  end

  def spare_bonus(index)
    #@frames[index + 1].shots.first.score
    #@frames[index + 1].score(1)
    @frames[index + 1].calc_score(1)
  end
end
