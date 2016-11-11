puts "Program: Triangle area"

print 'Input base of the triangle: '
triangle_base = gets.chomp.to_f

print 'Input height of the triangle: '
triangle_height = gets.chomp.to_f

triangle_area = (triangle_base * triangle_height) / 2

puts "Triangle area is: #{triangle_area}"