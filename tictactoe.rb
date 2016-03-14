#Methods
def draw_board(b)
  system "cls" #For Windows users
  system 'clear' #For *nix users
  puts "  #{b[1]}  |  #{b[2]}  |  #{b[3]}  "
  puts "-----------------"
  puts "  #{b[4]}  |  #{b[5]}  |  #{b[6]}  "
  puts "-----------------"
  puts "  #{b[7]}  |  #{b[8]}  |  #{b[9]}"
end

def create_board(b)
  (1..9).each {|num| b[num] = " "}
end

def board_full?(b)
  b.has_value?(" ")
end

def find_available_squares(b)
  b.select {|k, v| v == " "} 
end

def player_pick(b)
  begin 
    puts 'please pick an open square (1-9)'
    choice = gets.chomp.to_i
  end until find_available_squares(b).has_key?(choice)
  b[choice] = "X"
  draw_board(b) 
end

def computer_pick(b)
  available_squares = find_available_squares(b) 
  choice = available_squares.keys.sample
  b[choice] = "O"
  draw_board(b)
end   

def winner?(b, player_piece)
  game_over = false 
  winning_rows = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  winning_rows.each do |winning_squares|
    if b[winning_squares[0]] == player_piece &&  
       b[winning_squares[1]] == player_piece &&  
       b[winning_squares[2]] == player_piece
     game_over = true
    end
  end
  return game_over
end

#variables
board = {}

create_board(board)
draw_board(board)

#main program
begin  
  player_pick(board)
  if winner?(board, "X")
    puts "\nPlayer Wins!"
    break
  end
  computer_pick(board) 
  if winner?(board, "O")
    puts "\nComputer Wins!"
    break
  end
end until !board_full?(board)

if !board_full?(board)
  puts "It's a tie. All squares are gone."
end
