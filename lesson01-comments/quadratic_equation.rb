puts 'Program: Quadratic equation'
puts 'Quadratic equation has next view:'
puts 'Ax^2 + Bx + C = 0'
puts '----------------------------------'

# Input
print 'Input A: '
a = gets.chomp.to_f

print 'Input B: '
b = gets.chomp.to_f

print 'Input C: '
c = gets.chomp.to_f

# computing
d = b**2 - 4 * a * c

print "Discriminant is: #{d}"
puts ', no solution in the real numbers' if d < 0 # нет решений в области действительных чисел
puts ", x1 = #{(-b + Math.sqrt(d))/ (2 * a)}, x2 = #{(-b - Math.sqrt(d))/(2 * a)}" if d > 0 # обычное решение a = 71, b = 144, c = 4
puts ", x1 = x2 = #{-b / (2 * a)}" if d == 0 # корни равны a = 9, b = -30, c = 25