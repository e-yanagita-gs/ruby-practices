#!/usr/bin/env ruby

(1..20).each do |number|  
  if number.modulo(3)==0 && number.modulo(5)==0
    puts "FizzBuzz"
  elsif number.modulo(3)==0
    puts "Fizz"
  elsif number.modulo(5)==0
    puts "Buzz"
  else
    puts number
  end
end
