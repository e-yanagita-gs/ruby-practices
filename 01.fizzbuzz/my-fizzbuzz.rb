# 配列を使う方法
numbers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]

numbers.each do |number|
  case
  when number.modulo(3)==0 && number.modulo(5)==0
    puts "FizzBuzz"
  when number.modulo(3)==0
    puts "Fizz"
  when number.modulo(5)==0
    puts "Buzz"
  else
    puts number
  end
end

=begin
# 繰り返しを使う方法１
number=1
while number <= 20
  case
  when number%3==0 && number%5==0
    puts "FizzBuzz"
    number += 1
  when number%3==0
    puts "Fizz"
    number += 1
  when number%5==0
    puts "Buzz"
    number += 1
  else
    puts number
    number += 1
  end
end

# 繰り返しを使う方法２
number = 1
20.times do
  case
  when number.modulo(3)==0 && number.modulo(5)==0
    puts "FizzBuzz"
    number += 1
  when number.modulo(3)==0
    puts "Fizz"
    number += 1
  when number.modulo(5)==0
    puts "Buzz"
    number += 1
  else
    puts number
    number += 1
  end
end
=end
