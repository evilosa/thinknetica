puts "Lesson 2 - Task 3"

result = [0, 1]
loop do
  newVal = result[-2] + result[-1]
  break if newVal >= 100
  result << newVal
end

puts "Result: #{result}"
