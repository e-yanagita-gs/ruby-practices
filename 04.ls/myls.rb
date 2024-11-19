#!/usr/bin/env ruby
# frozen_string_literal: true

def main
  output_files(list_files)
end

def list_files
  Dir.glob('*')
end

def output_files(file_names, cols = 3)
  # 要件を満たすための行数を求め、行列形式の配列をつくる（row:行,col:列）
  rows = (file_names.size % cols).zero? ? file_names.size / cols : file_names.size / cols + 1
  matrix_file_names = Array.new(rows) { Array.new(cols) }

  # 作成した配列にファイル名を割り当てていく
  file_names.each_with_index do |file, index|
    row = index % rows
    col = index / rows
    matrix_file_names[row][col] = file
  end

  # 各列の最大長を計算
  col_max_lengths = Array.new(cols) do |col|
    matrix_file_names.map { |row| row[col].to_s.length }.max
  end

  matrix_file_names.each do |row|
    row.each_with_index do |file, col|
      print file.to_s.ljust(col_max_lengths[col] + 2)
    end
    puts
  end
end

main
