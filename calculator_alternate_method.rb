require 'pry'

def delete_two_elements(equation_array, index)
  equation_array.delete_at(index)
  equation_array.delete_at(index)
end
def calculate(equation_array)

  equation_array.each_with_index do |element, index|
    if element == "*"
      equation_array[index - 1] = equation_array[index - 1].to_f * equation_array[index + 1].to_f
      delete_two_elements(equation_array, index)
      calculate(equation_array)
    elsif element == "/"
      equation_array[index - 1] = equation_array[index - 1].to_f / equation_array[index + 1].to_f
      delete_two_elements(equation_array, index)
      calculate(equation_array)
    else 
      next
    end     
  end

  equation_array.each_with_index do |element, index|
    if element == "+"
      equation_array[index - 1] = equation_array[index - 1].to_f + equation_array[index + 1].to_f
      delete_two_elements(equation_array, index)
      calculate(equation_array)
    elsif element == "-"
      equation_array[index - 1] = equation_array[index - 1].to_f - equation_array[index + 1].to_f
      delete_two_elements(equation_array, index)
    else 
      next
    end     
  end
return equation_array[0]
end

do_again = 'y'
while do_again == 'y'
  puts "Please enter your equation with a space between each number and operator."
  puts "For example, 3 + 2 / 5 * 6" + " (Unfortunately, can't handle parenthesis yet.)"
  print "=>"
  equation = gets.chomp
  
  total = calculate(equation.split)

  # Checks if total (a float) is really an integer and if so converts it.
  length = total.to_s.length
  if total.to_s[length - 1] == "0" 
    total = total.to_i
  end
  puts "Your result is #{total}."
  puts '-------'
  puts "Would you like to do another calculation?" 
  puts "Enter 'y' for 'yes' or any other key to quit."
  do_again = gets.chomp
end
