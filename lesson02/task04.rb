puts "Lesson 2 - Task 4"
result = {}
vowels = 'aeiouy'.split("")
alphabet = 'a'..'z'

vowels.each { |i| result[i] = alphabet.find_index(i).next }
puts "Result: #{result}"
