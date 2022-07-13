class Game
    attr_accessor :board, :player1, :player2, :current_player_id

    WIN_COMBINATIONS = [
        [0, 1, 2], [0, 4, 8], [0, 3, 6], [1, 4, 7], 
        [2, 5, 8], [2, 4, 6], [3, 4, 5], [6, 7, 8]
    ]

    def initialize
        @board = (1..9).to_a
        @player1 = nil
        @player2 = nil
        @current_player_id
    end

    def play
        player_setup
        print_board
        gaming
        ending
    end
    
    def full?
        board.all? { |e| !e.is_a? Integer}
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
        if @current_player_id == @player1
            @current_player_id = @player2
        else
            @current_player_id = @player1
        end
    end

    def winner?
        WIN_COMBINATIONS.any? do |combo|
            [board[combo[0]], board[combo[1]], board[combo[2]]].uniq.length == 1
        end   
    end

    def ending 
        if winner?
            puts " #{current_player_id.name} won!"
        else
            puts "It's a tie!"
        end
    end

    def turn(player)
        puts "Please #{player.name} enter an empty position on the board to put your marker, choose between the numbers 1-9"
        player_input = input_to_index(gets.chomp.to_i)
        valid_input?(player_input)
        board[player_input] = player.symbol

        print_board
    end

    def gaming
        @current_player_id = player1
        until full?
            turn(current_player_id)
            break if winner?

            @current_player_id = change_player
        end

    end

    def valid_input?(input)
        return input if board[input] != player1.symbol && board[input] != player2.symbol && input != /[^1-9]/i

        puts "Your choice was not valid. Please choose an empty position on the board"
        turn(@current_player_id)
    end

    def create_player(duplicate = nil)
        puts "Choose the name for the player "
        name = gets.chomp
        symbol = symbol_new(duplicate)
        Player.new(name, symbol)
    end

    def symbol_new(duplicate)
        input = gets.chomp
        if input == duplicate
            puts "You have chosen the same symbol as player 1, choose an unique symbol "
        elsif input.length != 1
            puts "Please choose a symbol with only one character"
        elsif input.match(/[0-9]/)
            puts "Please choose a symbol that is not a number"
        else
            return input
        end
        symbol_new(duplicate)
    end

    def player_setup
        @player1 = create_player
        @player2 = create_player(player1.symbol)

    end
end

class Player
    attr_reader :name, :symbol
    
    def initialize(playername, symbol)
        @name = playername
        @symbol = symbol
    end

end

x = Game.new.play



