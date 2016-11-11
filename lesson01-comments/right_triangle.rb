puts 'Program: Right triangle'

print 'Input first side: '
first_side = gets.chomp.to_f

print 'Input second side: '
second_side = gets.chomp.to_f

print 'Input third side: '
third_side = gets.chomp.to_f

# Create array, insert and order values
sides = [ first_side, second_side, third_side ]
puts "Source sides info: #{sides}"
sides.sort_by! { |s| -s}
puts "Sides after sort: #{sides}"

unique_sides = sides.uniq.to_ary

if unique_sides.length == 1 # Равносторонний, сообщаем о свойствах
  puts 'The triangle is equilateral'
else # иначе проверяем на прямоугольность
  if (sides.first ** 2) == (sides[1] ** 2 + sides[2] ** 2)
    puts 'This is right triangle'
  else
    puts 'This is just a common triangle'
  end
end

print ', and the isosceles' if unique_sides.length == 2
