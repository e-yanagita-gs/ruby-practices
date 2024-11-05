#!/usr/bin/env ruby
require 'optparse'
require 'date'

#引数（m:月、y:年）を設定
opt = OptionParser.new

params = {}

opt.on('-m MONTH',Integer) {|v| v}
opt.on('-y YEAR',Integer)  {|v| v}

opt.parse!(ARGV,into: params)

#引数がない場合、今日の月・年を取得
if params.empty?
  params = {}
  today = Date.today
  params[:m] = today.month
  params[:y] = today.year
end

#見出し：年・月・曜日の表示
first_date = Date.new(params[:y], params[:m], 1)
puts "#{first_date.strftime('%B')} #{params[:y]}".center(20)
day_of_week = ["Su","Mo","Tu","We","Th","Fr","Sa"]
puts day_of_week.join(' ')

#指定月の１日の曜日を求めて該当する曜日の下に記載
start_day = 1
start_day_w = first_date.wday #１日の曜日を取得
print start_day.to_s.rjust(3 * start_day_w + 2) + " " 
if first_date.saturday?
  print "\n"
end

#指定月の２日～最終日のカレンダーを作成
start_day += 1
last_day = Date.new(params[:y], params[:m], -1)
while start_day <= last_day.day
  print start_day.to_s.rjust(2) + " "
  weekday = Date.new(params[:y], params[:m], start_day)
  if weekday.saturday?
    print "\n"
  end
  start_day += 1
end

