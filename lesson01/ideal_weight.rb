puts 'Program: Ideal weight'
print 'Input your name: '
name = gets.chomp.capitalize

print 'Input your height: '
height = gets.chomp.to_f
ideal_weight = height - 110

puts "#{name} your weight is #{height}" if ideal_weight >= 0
puts "#{name} your weight is ideal" if ideal_weight < 0
