#1 draw display
#2 create a new deck, a hash of card value and points for that card
#3 deal a card = move a random card from the deck into a player's hand
  #3 and delete it from the deck)
#4 deal player and dealer two cards each. 
  #4 both player's cards are face up. dealer has one down 
#4A player cards are summed and the sum is displayed. if they total 21, player wins.
#5 if not, player chooses to hit or stay
#6 if player chooses to hit they are dealt a new card
#7 this continues until the player hits goes over 21 or chooses to stay
#8 if computer has less than 17, the dealer must hit.
#9 if the dealer hits 21, the dealer wins automatically.
#10 if the dealer has more than 17, the dealer will stay and hands will be compared.
require "pry"

def say(msg)
  puts msg
end

def say_greeting
  say "\n\nWelcome to Blackjack!"
  sleep 1
  say "Shuffling the deck..."
  sleep 1
end

def deal_card(current_deck, dealt_cards, whose_turn)
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
  total[whose_turn] = 0 
  dealt_cards[whose_turn].values.each do |card_value|
    total[whose_turn] = total[whose_turn] + card_value
  end
  if total[whose_turn] > 21 && has_unconverted_ace?(dealt_cards, whose_turn)
    binding.pry
    ace_11_to_1_conversion(dealt_cards, whose_turn)
    update_totals(dealt_cards, total, whose_turn)    
  end
end

def has_unconverted_ace?(dealt_cards, whose_turn)
  dealt_cards[whose_turn].has_value?(11)
end

def ace_11_to_1_conversion(dealt_cards, whose_turn)
  ace = dealt_cards[whose_turn].key(11)
  dealt_cards[whose_turn][ace] = 1    

    # if index = (dealt_cards[whose_turn].has_key?(" AH") &&
    #            dealt_cards[whose_turn][" AH"] == 11)
    #   dealt_cards[whose_turn][" AH"] = 1
    # elsif index = dealt_cards[whose_turn].has_key?(" AC")
    #   dealt_cards[whose_turn][" AC"] = 1
    # elsif index = dealt_cards[whose_turn].has_key?(" AD")
    #   dealt_cards[whose_turn][" AD"] = 1
    # elsif index = dealt_cards[whose_turn].has_key?(" AS")
    #   dealt_cards[whose_turn][" AS"] = 1        
    # end
end  

def determine_player_choice
  begin
  say "\nWould you like to hit or stay (h/s)"
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

def say_player_results(total)
  say "\nPlayer stays at #{total[:player]}" if total[:player] < 21
  say "\n21 will be tough to beat." if total[:player] == 21
  say "\nYou have #{total[:player]}." if total[:player] > 21
end

def say_computer_results(total)
  say "\nComputer wins!" if total[:computer] > total[:player] && 
                            total[:computer] <= 21
  say "\nIt's a push." if total[:computer] == total[:player]
  say "\nComputer busted with #{total[:computer]}." if total[:computer] > 21
  sleep 1
end

DECK = {
          " AS" => 11,  
          " AC" => 11, 
          " AH" => 11,  
          " AD" => 11, " 9D" => 9, "10D" => 10,
          " JD" => 10, " QD" => 10, " KD" => 10    

        }
# need to handle ace 1 or 11
say_greeting

loop do
  dealt_cards = {player: {}, computer: {}}
  total = {player: 0, computer: 0}
  whose_turn = :player
  current_deck = DECK.dup

  initial_deal(current_deck, dealt_cards)
  update_totals(dealt_cards,total, whose_turn)
  computers_hidden_card = hide_hole_card_from_display(dealt_cards)
  display_table(dealt_cards, total, whose_turn)

  while total[:player] < 21
    if determine_player_choice == "h"
      deal_card(current_deck,dealt_cards, whose_turn)
      update_totals(dealt_cards, total, whose_turn)
      display_table(dealt_cards, total, whose_turn)
    else
      break
    end
  end
  say_player_results(total)
  sleep 1
  if total[:player] > 21
    say "You busted!" 
  elsif total[:player] <= 21 || total[:player] < total[:computer]
    whose_turn = :computer
    retrieve_hole_card(computers_hidden_card, dealt_cards)
    update_totals(dealt_cards, total, whose_turn)
    say "Computer's hole card is a #{computers_hidden_card}" + 
        " for a total of #{total[:computer]}"
    sleep 3
    system "cls"
    display_table(dealt_cards, total, whose_turn)
    sleep 2
    while total[:computer] < total[:player] || total[:computer] < 17
      say "\nComputer hits."
      sleep 1
      deal_card(current_deck, dealt_cards, whose_turn)
      update_totals(dealt_cards, total, whose_turn)
      display_table(dealt_cards, total, whose_turn)
      sleep 1     
    end   
  end
  say_computer_results(total) 
  say "\nWould you like to play again? (y/n)"
  exit if gets.chomp.downcase != "y"
end