class Game
    attr_accessor :board, :player1, :player2, :current_player_id

    #Skapa en serie av vinnande möjligheter, spelet ska avslutas när någon av kombinationerna är uppnådd.

    def initialize
        @board = (1..9).to_a
        @player1 = nil
        @player2 = nil
        @current_player_id = 0

        player_setup
    end

    def print_board
        column = "---+---+---"

        puts " #{board[0]} | #{board[1]} | #{board[2]}"
        puts column  
        puts " #{board[3]} | #{board[4]} | #{board[5]}"
        puts column
        puts " #{board[6]} | #{board[7]} | #{board[8]}"
    end

    def input_to_index(input)
        input - 1
    end

    def change_player
        value = (@current_player_id % 2).even?
        @current_player_id +=1
        return value
    end

    def turn
        puts "Please enter an empty position on the board to put your marker, choose between the numbers 1-9"
        player_input = input_to_index(gets.chomp.to_i)
        valid_input?(player_input)
        if change_player then board[player_input] = player1.symbol else board[player_input] = player2.symbol end
        print_board

        turn
    end

    def valid_input?(input)
        return input if board[input] != player1.symbol && board[input] != player2.symbol

        puts "Your choice was not valid. Please choose an empty position on the board"
        turn
    end

    def create_player(duplicate = nil)
        puts "Choose the name for the player "
        name = gets.chomp
        symbol = symbol_new(duplicate)
        Player.new(name, symbol)
    end

    def symbol_new(duplicate)
        input = gets.chomp
        return input if input != duplicate
        puts "You have chosen the same symbol as player 1, choose a unique symbol "
        symbol_new(duplicate)
    end

    def player_setup
        @player1 = create_player
        @player2 = create_player(player1.symbol)

        turn
    end
    
end

class Player
    attr_reader :name, :symbol
    
    def initialize(playername, symbol)
        @name = playername
        @symbol = symbol
    end

end

x = Game.new()



