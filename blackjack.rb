# blackjack - Oscar Daniels
def say(msg, name)
  puts msg
end

def say_greeting(name)
  # "Oscar"
  say("\n\nWelcome to Blackjack!", name)
  sleep 1
  say("What's your name?", name)
  name = gets.chomp.capitalize
  say("Hi #{name}. I'm shuffling the deck...", name)
  sleep 2
  name
end

def deal_card(current_deck, dealt_cards, whose_turn)
  # {" 3D" => 3, "10S" => 10 }, {:player => {" 4H" => 4}...}, :player
  system "cls"
  key = current_deck.keys.sample
  value = DECK.values_at(key).first
  dealt_cards[whose_turn][key] = value
  current_deck.delete(key)
end

def initial_deal(current_deck, dealt_cards)
  2.times {deal_card(current_deck, dealt_cards, :player)}
  2.times {deal_card(current_deck, dealt_cards, :computer)}
end

def update_totals(dealt_cards, total, whose_turn)
  # total parameter {:player => 22, :computer => 19}
  total[whose_turn] = 0 
  dealt_cards[whose_turn].values.each do |card_value|
    total[whose_turn] += card_value
  end
  if total[whose_turn] > 21 && unconverted_ace?(dealt_cards, whose_turn)
    ace_11_to_1_conversion(dealt_cards, whose_turn)
    update_totals(dealt_cards, total, whose_turn)    
  end
end

def unconverted_ace?(dealt_cards, whose_turn)
  dealt_cards[whose_turn].has_value?(11)
end

def ace_11_to_1_conversion(dealt_cards, whose_turn)
  ace = dealt_cards[whose_turn].key(11)
  dealt_cards[whose_turn][ace] = 1    
end  

def hit_or_stay(name)
  begin
  say("\n#{name}, would you like to hit or stay (h/s)", name)
  choice = gets.chomp.downcase
  end until choice == 'h' or choice == 's'
  choice
end

def display_table(dealt_cards, total, whose_turn)
  print "\nPlayer  | "
  dealt_cards[:player].keys.each {|card| print card + " "}
  print "| Total = #{total[:player]}"
  puts "\n------------------------------"
  print "Computer| "
  dealt_cards[:computer].keys.each {|card| print card + " "}
  print "| Total = #{total[:computer]}" if whose_turn == :computer
  puts
end

def hide_hole_card_from_display(dealt_cards)
  computers_hidden_card = dealt_cards[:computer].keys.first
  dealt_cards[:computer][" ??"] = 0
  dealt_cards[:computer].delete(computers_hidden_card)
  computers_hidden_card
end

def retrieve_hole_card(computers_hidden_card, dealt_cards)
  dealt_cards[:computer].delete(" ??")
  dealt_cards[:computer][computers_hidden_card] = DECK[computers_hidden_card]
end

def say_player_results(total, name)
  say("\n#{name} stays at #{total[:player]}", name) if total[:player] < 21
  say("\n21 will be tough to beat.", name) if total[:player] == 21
  say("\nYou have #{total[:player]}.", name) if total[:player] > 21
end

def say_computer_results(total, name)
  say("\nComputer wins!", name) if total[:computer] > total[:player] && 
                                   total[:computer] <= 21
  say("\nIt's a push.", name) if total[:computer] == total[:player]
  say("\nComputer busted with #{total[:computer]}.", name) if total[:computer] > 21
  sleep 1
end

DECK = {
          " AS" => 11,  " 2S" => 2,  " 3S" => 3, " 4S" => 4, " 5S" => 5, 
          " 6S" => 6,  " 7S" => 7,  " 8S" => 8, " 9S" => 9, "10S" => 10,
          " JS" => 10, " QS" => 10, " KS" => 10, 
          " AC" => 11,  " 2C" => 2,  " 3C" => 3, " 4C" => 4, " 5C" => 5, 
          " 6C" => 6,  " 7C" => 7,  " 8C" => 8, " 9C" => 9, "10C" => 10,
          " JC" => 10, " QC" => 10, " KC" => 10,
          " AH" => 11,  " 2H" => 2,  " 3H" => 3, " 4H" => 4, " 5H" => 5, 
          " 6H" => 6,  " 7H" => 7,  " 8H" => 8, " 9H" => 9, "10H" => 10,
          " JH" => 10, " QH" => 10, " KH" => 10,
          " AD" => 11,  " 2D" => 2,  " 3D" => 3, " 4D" => 4, " 5D" => 5, 
          " 6D" => 6,  " 7D" => 7,  " 8D" => 8, " 9D" => 9, "10D" => 10,
          " JD" => 10, " QD" => 10, " KD" => 10    
        }
name = ""

#Start Game

name = say_greeting(name) 
loop do
  dealt_cards = {player: {}, computer: {}}
  total = {player: 0, computer: 0}
  whose_turn = :player
  current_deck = DECK.dup
  initial_deal(current_deck, dealt_cards)
  update_totals(dealt_cards,total, whose_turn)
  computers_hidden_card = hide_hole_card_from_display(dealt_cards)
  display_table(dealt_cards, total, whose_turn)

#Player Turn

  while total[:player] < 21
    if hit_or_stay(name) == "h"
      deal_card(current_deck,dealt_cards, whose_turn)
      update_totals(dealt_cards, total, whose_turn)
      display_table(dealt_cards, total, whose_turn)
    else
      break
    end
  end

# Display Player Results

  say_player_results(total, name)
  sleep 1
  if total[:player] > 21
    say("You busted!", name) 
  else 
    whose_turn = :computer

# Computer Reveals Hole Card

    retrieve_hole_card(computers_hidden_card, dealt_cards)
    update_totals(dealt_cards, total, whose_turn)
    say("Computer's hole card is a #{computers_hidden_card}" + 
        " for a total of #{total[:computer]}", name)
    sleep 3
    system "cls"
    display_table(dealt_cards, total, whose_turn)
    sleep 2

# Computer Turn

    while total[:computer] < total[:player] || total[:computer] < 17
      say("\nComputer hits.", name)
      sleep 1
      deal_card(current_deck, dealt_cards, whose_turn)
      update_totals(dealt_cards, total, whose_turn)
      display_table(dealt_cards, total, whose_turn)
      sleep 1     
    end   
  end

# Display Computer Results

  say_computer_results(total, name) 
  say("\n#{name}, would you like to play again? (y/n)", name)
  exit if gets.chomp.downcase != "y"
end