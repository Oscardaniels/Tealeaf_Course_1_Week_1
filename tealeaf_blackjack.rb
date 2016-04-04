def calculate_total(cards)
  # [["H", "3"], ["S", "10"],...]
  arr = cards.map{|e| e[1]}
  total = 0
  arr.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0
      total += 10
    else
      total += value.to_i
    end
  end

  arr.select {|e| e == "A"}.count.times do
    total -= 10 if total > 21
  end
  total
end

puts "Welcome to Blackjack"

suits = ["H", "C", "S", "D"]
cards = ["2", "3", "4", "5", "6", "7", "8", "9", "J", "Q", "K", "A"]


deck = suits.product(cards)
deck.shuffle!

mycards = []
dealercards = []

#Deal Cards

mycards << deck.pop
dealercards << deck.pop
mycards << deck.pop
dealercards << deck.pop

dealertotal = calculate_total(dealercards)
mytotal = calculate_total(mycards)

# Show Cards

puts "Dealer has: #{dealercards[0]} and #{dealercards[1]}, for a total of #{dealertotal}."
puts "You have: #{mycards[0]} and #{mycards[1]}, for a total of: #{mytotal}."
puts ""

# Player Turn
if mytotal == 21
  puts "Congratulations, you hit blackjack"
  exit
end
while mytotal < 21
  puts "Would you like to 1) hit or 2) stay?"
  hit_or_stay = gets.chomp
  if !["1", "2"].include?(hit_or_stay)
    puts "Error. You must enter 1 or 2"
    next
  end

  if hit_or_stay == "2"
    puts "You chose to stay"
    break
  end

  #hit
  new_card = deck.pop
  puts "Dealing card to player: #{new_card}"
  mycards << new_card
  mytotal = calculate_total(mycards)
  puts "your total is #{mytotal}"

  if mytotal == 21
    puts "Congratulations, you hit blackjack"
    exit
  elsif mytotal > 21
    puts "Sorry you busted"
    exit    
  end
end

#Dealer Turn

if dealertotal == 21
  puts "Sorry, dealer hit blackjack. You lose."
  exit
end

while dealertotal < 17

  new_card = deck.pop
  puts "Dealing new card for dealer: #{new_card}"
  dealercards << new_card
  dealertotal = calculate_total(dealercards)
  puts "Dealer total is now: #{dealertotal}"
end
if dealertotal == 21
  puts "Sorry dealer hit blackjack. you lose."
  exit
elsif dealertotal > 21
  puts "Congratulations, dealer busted! You win!"
  exit
end

puts "Dealer's cards: "
dealercards.each do |card|
  puts "=> #{card}"
end

puts "Your cards: "
mycards.each do |card|
  puts "=> #{card}"
end

if dealertotal > mytotal
  puts "Sorry, dealer wins."
elsif mytotal > dealertotal
  puts "You win"
else
  puts "It's a push"
end