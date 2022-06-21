class Game
    attr_reader :board

    def initialize
       @board = Array.new(10) {|i| i.to_s}
        print_board
    end
    
    def print_board
        row = "|"
        column = "---+---+---"

        puts " #{board[1]} | #{board[2]} | #{board[3]}"
        puts column  
        puts " #{board[4]} | #{board[5]} | #{board[6]}"
        puts column
        puts " #{board[7]} | #{board[8]} | #{board[9]}"
    end

end

class Player
end

x = Game.new


