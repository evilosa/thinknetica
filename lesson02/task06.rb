puts "Lesson 2 - Task 6"
result = {}

loop do
  puts 'Product:'
  product = gets.chomp

  break if product == 'stop'

  if result[product].nil?
      puts 'Price:'
      price = gets.chomp.to_f

      puts 'Count:'
      count = gets.chomp.to_f

      result[product] = { :price => price, :count => count}
  else
    puts "Input additional count for product #{product}"
    count = gets.chomp.to_f
    result[product][:count] += count
  end
end

if result.size > 0
  total, row_number = 0

  result.each { |product, data|
    sum = data[:count] * data[:price]
    total += sum
    puts "#{product}: #{data[:price].to_s} x #{data[:count].to_s} = #{sum.to_s}"
  }
  puts "Total: #{total}"
else
  puts "The cart is empty"
end
