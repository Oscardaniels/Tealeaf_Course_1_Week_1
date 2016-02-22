require 'pry'
do_again = 'y'
while do_again == 'y'
  puts "Please enter a number."
  print "=>"
  total = gets.chomp

  loop  do 
    puts "Enter an operator at the prompt or hit 'enter' for a result"
    print "(+,-,*,/)=>"
    operator = gets.chomp

    if operator != ""
      puts "Please enter a number."
      print "=>"
      new_number = gets.chomp
      case 
        
      when operator == "+"
        total = total.to_f + new_number.to_f
      when operator == "-"
        total = total.to_f - new_number.to_f
      when operator == "*"
        total = total.to_f * new_number.to_f
      else  
        total = total.to_f / new_number.to_f  
      end
    else
      break
    end
  end

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
