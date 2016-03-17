# Tic Tac Toe Program - Oscar Daniels
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

def initialize_board(b)
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
  if can_computer_win?(b)
    return
  elsif can_computer_block?(b)      
    return
  else
    available_squares = find_available_squares(b) 
    choice = available_squares.keys.sample
    b[choice] = "O"
    draw_board(b)
  end
end

def can_computer_win?(b)
  WINNING_ROWS.each do |winning_row|
    values = b.values_at(winning_row[0], winning_row[1], winning_row[2])
    if values.count("O") == 2 && values.count(" ") == 1
      computer_move(b, winning_row)
      return true
    end
  end
  false
end

def can_computer_block?(b)
  WINNING_ROWS.each do |winning_row|
    values = b.values_at(winning_row[0], winning_row[1], winning_row[2])
    if values.count("X") == 2 && values.count(" ") == 1
      computer_move(b, winning_row)
      return true
    end
  end
  false
end

def computer_move(b, target_squares)
  target_squares.each do |square| 
    if b[square] == " "
      b[square] = "O"
      draw_board(b)  
    end
  end
end   

def winner?(b, player_piece)
  game_over = false 
  WINNING_ROWS.each do |winning_row|
    if winning_row.all? {|square| b[square] == player_piece}
     game_over = true
    end
  end
  return game_over
end

#variables and constants
board = {}
WINNING_ROWS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

#main program
initialize_board(board)
draw_board(board)
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

if !board_full?(board) && !winner?(board, "X") && !winner?(board, "O")
  puts "It's a tie. All squares are gone."
end