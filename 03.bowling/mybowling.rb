#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
input_frames = []
edit_frames = []

# 入力されたスコアを整数値の配列(input_frames)に変換
scores.flat_map do |s|
  fallen_pin = s == 'X' ? 10 : s.to_i
  input_frames.push(fallen_pin)
end

# スコアを２投（１フレーム）ずつにスライス(edit_framess)
# ただし、ストライクの場合は１投１フレームになるようスライス
count = 0
while count < input_frames.size
  if input_frames[count] == 10
    edit_frames << [input_frames[count]]
    count += 1
  else
    edit_frames << input_frames[count, 2]
    count += 2
  end
end

# ストライク・スペア時のボーナスポイントの計算
def calc_bonus_point(frame, frames, count)
  if frame[0] == 10 # ストライク
    frames[count + 1..].flatten.take(2).sum
  elsif frame.sum == 10 # スペア
    frames[count + 1..].flatten.take(1).sum
  else
    0
  end
end

# 総スコアの計算
total_point = 0
edit_frames.take(10).each_with_index do |raw_score, index|
  total_point += raw_score.sum + calc_bonus_point(raw_score, edit_frames, index)
end

puts total_point
