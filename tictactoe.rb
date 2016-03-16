require "pry"
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

def can_computer_win(b, winning_rows)
  winning_rows.each do |winning_row|
    values = b.values_at(winning_row[0], winning_row[1], winning_row[2])
    if values.count("O") == 2 && values.count(" ") == 1
      b[winning_row.index(" ")] = "O"
      winning_row.each do |square| 
        if b[square] == " "
          b[square] = "O"   
        end
      end
      draw_board(b)
      return true
    end
  end
  false
end

def can_computer_block(b, winning_rows)
  winning_rows.each do |winning_row|
    values = b.values_at(winning_row[0], winning_row[1], winning_row[2])
    if values.count("X") == 2 && values.count(" ") == 1
      b[winning_row.index(" ")] = "O"
      winning_row.each do |square| 
        if b[square] == " "
          b[square] = "O"
          binding.pry   
        end
      end
      draw_board(b)
      return true
    end
  end
  false
end

def computer_pick(b, winning_rows)
  if can_computer_win(b, winning_rows)
    return
  elsif can_computer_block(b, winning_rows)      
    return
  else
    available_squares = find_available_squares(b) 
    choice = available_squares.keys.sample
    b[choice] = "O"
    draw_board(b)
  end
  
end   

def winner?(b, player_piece, winning_rows)
  game_over = false 
  winning_rows.each do |winning_row|
    if b[winning_row[0]] == player_piece &&  
       b[winning_row[1]] == player_piece &&  
       b[winning_row[2]] == player_piece
     game_over = true
    end
  end
  return game_over
end

#variables
board = {}
winning_rows = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

#main program
initialize_board(board)
binding.pry
draw_board(board)

begin  
  player_pick(board)
  if winner?(board, "X", winning_rows)
    puts "\nPlayer Wins!"
    break
  end
  computer_pick(board, winning_rows) 
  if winner?(board, "O", winning_rows)
    puts "\nComputer Wins!"
    break
  end
end until !board_full?(board)

if !board_full?(board) && !winner?(board, "X", winning_rows) && !winner?(board, "O", winning_rows)
  puts "It's a tie. All squares are gone."
end
