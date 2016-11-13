puts "Lesson 2 - Task 5"
days_in_month = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]
year, month, day = 0

puts "Input year"
loop do
  year = gets.chomp.to_f
  break if year > 0
  puts "Year must be positive, input correct year"
end

puts "Input month"
loop do
  month = gets.chomp.to_f
  break if (1..12) === month
  puts "Month is incorrect, input correct month"
end

puts "Input day"
loop do
  day = gets.chomp.to_f
  break if (1..31) === day
  puts "Day is incorrect, input correct day of month"
end

is_leap_year = year % 4 == 0 && !(year % 100 == 0) || year % 400 == 0
days_in_month[1] = 29 if is_leap_year

result = day
if month > 1
  days_in_month[0...month-1].each{ |days| result += days }
end

puts "#{day}.#{month}.#{year} is #{result} day in year"
