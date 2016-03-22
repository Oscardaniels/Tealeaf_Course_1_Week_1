require "pry"
# array = [["O", "X", "1"], ["J", "O", "X"]]
# array.each do |winning_combination|
#   begin 
#     original = winning_combination
#       if winning_combination[0] == "X" && winning_combination[1] == "X" 
#         block = winning_combination[2]
#       end 
#       binding.pry
#         winning_combination.rotate!
#   end unless winning_combination == original 
# end

# array = [["1", "2", "3"], ["A", "B", "C"]]
# array.each do |winning_combination|
# rotated = []
#   while winning_combination != rotated
#     rotated = winning_combination.rotate
#         binding.pry
#   end 
# end


 # Tic Tac Toe Program - Oscar Daniels
#Methods
b = {}
(1..9).each {|num| b[num] = " "}

def check_winner(board)
  winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  winning_lines.each do |line|

    binding.pry
    return "Player" if board.values_at(*line).count('X') == 3
    return "Computer" if board.values_at(*line).count('O') == 3
  end
  nil
end

check_winner(b)