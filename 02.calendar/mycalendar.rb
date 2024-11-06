#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'date'

# 引数（m:月、y:年）を設定
opt = OptionParser.new

params = {}

opt.on('-m MONTH', Integer) { |v| v }
opt.on('-y YEAR', Integer)  { |v| v }

opt.parse!(ARGV, into: params)

# 引数がない場合、今日の月・年を取得
if params.empty?
  params = {}
  today = Date.today
  params[:m] = today.month
  params[:y] = today.year
end

# 見出し：年・月・曜日の表示
first_date = Date.new(params[:y], params[:m], 1)
last_date = Date.new(params[:y], params[:m], -1)
puts "#{first_date.strftime('%B')} #{params[:y]}".center(20)
day_of_week = %w[Su Mo Tu We Th Fr Sa]
puts day_of_week.join(' ')

# 指定月の１日の曜日を求めて空欄を調整
first_date.wday.times { print '   ' }

# 指定月のカレンダーを作成
first_date.upto last_date do |date|
  print "#{date.day.to_s.rjust(2)} "
  print "\n" if date.saturday?
end
