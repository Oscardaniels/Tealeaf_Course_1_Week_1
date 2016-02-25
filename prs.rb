require 'pry'
def message(choice)
  case choice
  when 'r' then print "Rock smashes scissors."
  when 'p' then print "Paper covers rock."
  when 's' then print "Scissor cuts paper."
  end
    
end

CHOICES = {'r' => 'rock', 'p' => 'paper', 's' => 'scissors'}
puts "Welcome to Rock, Paper, Scissors!"
loop do
  begin
    puts "Choose your weapon: (p, r, s)."
    player_choice = gets.chomp.downcase
  end until CHOICES.keys.include?(player_choice)
  computer_choice = CHOICES.keys.sample
  puts "You chose #{CHOICES[player_choice]}. The computer chose #{CHOICES[computer_choice]}."
  
  if player_choice == computer_choice
    puts "It's a tie."
  elsif (player_choice == 'r' && computer_choice == 's') || 
        (player_choice == 's' && computer_choice == 'p') ||
        (player_choice == 'p' && computer_choice == 'r')
    message(player_choice)
    puts ' You won! '  
  else  
    message(computer_choice)
    puts ' Computer won!'
  end  


  puts "\nWould you like to go again? 'y' or 'n'" 
  break if gets.chomp.downcase != 'y'
end