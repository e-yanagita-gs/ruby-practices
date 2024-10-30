#!/usr/bin/env ruby

#引数（m:月、y:年）を設定
require 'optparse'
opt = OptionParser.new

params = {}

opt.on('-m MONTH',Integer) {|v| v}
opt.on('-y YEAR',Integer)  {|v| v}

opt.parse!(ARGV,into: params)

#引数がない場合、今日の月・年を取得
require 'date'
if params.empty?
  params = {}
  today = Date.today
  params[:m] = today.month
  params[:y] = today.year
end

#引数がない場合、今日の月・年を取得
require 'date'
if params.empty?
  params = {}
  today = Date.today
  params[:m] = today.month
  params[:y] = today.year
end

#見出し：年・月・曜日の表示
d = Date.new(params[:y],params[:m],1).strftime('%B') #月の名称の取得
puts "#{d} #{params[:y]}".center(20)
day_of_week = ["Su","Mo","Tu","We","Th","Fr","Sa"]
day_of_week.each do |x|
  print x + " "
end
print "\n"

#指定月の１日の曜日を求めて該当する曜日の下に記載
start_day = 1
start_day_w = Date.new(params[:y],params[:m],1).wday #１日の曜日を取得
print start_day.to_s.rjust(3*start_day_w+2) + " " 
if start_day_w == 6
  print "\n"
end

#指定月の２日～最終日のカレンダーを作成
start_day += 1
last_day = Date.new(params[:y],params[:m],-1)
while start_day <= last_day.day
  if start_day < 10
    print start_day.to_s.rjust(2) + " "
  else
    print start_day.to_s + " "
  end
  weekday = Date.new(params[:y],params[:m],start_day)
  if weekday in wday:6
    print "\n"
  end
  start_day += 1
end

