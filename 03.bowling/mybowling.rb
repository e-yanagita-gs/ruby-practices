#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

# 入力されたスコアを整数値の配列(frames)に変換
frames = scores.map do |s|
  s == 'X' ? 10 : s.to_i
end

# スコアを２投（１フレーム）ずつにスライス(edit_frames)
# ただし、ストライクの場合は１投１フレームになるようスライス
count = 0
edit_frames = []
while count < frames.size
  separator = frames[count] == 10 ? 1 : 2
  edit_frames << frames[count, separator]
  count += separator
end

# ストライク・スペア時のボーナスポイントの計算
def calc_bonus_point(frame, frames, count)
  bonus_count = if frame[0] == 10      # ストライク
                  2
                elsif frame.sum == 10  # スペア
                  1
                else
                  0
                end
  frames[count + 1..].flatten.take(bonus_count).sum
end

# 総スコアの計算
total_point = edit_frames.take(10).each_with_index.sum do |raw_score, index|
  raw_score.sum + calc_bonus_point(raw_score, edit_frames, index)
end

puts total_point
