class TicTacToe
    attr_accessor :turn_count, :current_player
    @@index
    @@winner = nil

    WIN_COMBINATIONS = [
        [0,1,2], #top horizontal
        [3,4,5], #middle horizontal
        [6,7,8], #bottom horizontal

        [0,3,6], #left vertical
        [1,4,7], #middle vertical
        [2,5,8], #right vertical

        [0,4,8], #up down cross
        [2,4,6] #down up cross
    ]


    def initialize(board = nil)
        @board = board || Array.new(9, " ")
    end

    def display_board
        p " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        p "-----------"
        p " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        p "-----------"
        p " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        p "[input_to_index]"
        @@index = input.to_i - 1 
        p "@index: #{@index}"
        @@index
    end

    def move(index, token = "X")
        p "[move]"
        @board[index] = token
        @board
    end

    def position_taken?(index)
        p "[position_taken]"
        @board[index] == " "? false : true
    end

    def valid_move?(index)
        p "[valid_move?]"
        if self.position_taken?(index) == false && index >= 0 && index <= 9
            p "position not taken for index: #{index}"
            p "index: #{index} within bounds"
            p "true"
            return true
        else
            p "position taken for index: #{index}"
            p "index: #{index} outside of bounds"
            p "false"
            return false
        end
    end

    def turn_count
        p "[turn_count]"
        @turn_count = 9 - @board.count(" ")
        p "@turncount: #{@turn_count}"
        @turn_count
    end

    def current_player
        p "[current_player]"
        self.turn_count % 2 == 0 ? @current_player = "X" : @current_player = "O"
        p "@current_player: #{@current_player}"
        @current_player
    end

    def turn
        p "[turn]"
        p "=================="
        p "please enter 1-9"
        p "=================="
        input = gets
        p "input: #{input}"
        input_to_index(input)
        p "=================="
        current_player
        p "=================="
        if valid_move?(@@index) == true
            move(@@index, @current_player)
            display_board
        elsif valid_move?(@@index) == false
            display_board
            turn
        end
    end

    def won?
        p "[won?]"
        p @board
        x = @board.each_index.select{|x| @board[x] =="X"}
        x.combination(3).each do |x|
            if WIN_COMBINATIONS.include?(x) == true
                p "winner: #{@@winner}"
                @@winner = "X"
                display_board
                return x
            end
        end
        o = @board.each_index.select{|x| @board[x] =="O"}
        o.combination(3).each do |o|
            if WIN_COMBINATIONS.include?(o) == true
                p "winner: #{@@winner}"
                @@winner = "O"
                display_board
                return o
            end
        end
        display_board
        false
    end

    def full?
        p "[full?]"
        display_board
        @board.include?(" ")? false : true
    end

    def draw?
        p "[draw?]"
        if full? == true && won? == false
            p "draw!"
            return true
        else
            p "no draw!"
            display_board
            return false
        end
    end
    
    def over?
        p "[over]"
        if draw? == true
            p "game over! - draw!"
            return true
        elsif won? != false
            p "game over! - winner!"
            return true
        else
            p "game not over!"
            return false
        end
    end

    def winner
        p "[winner]"
        @@winner = nil
        won?
        return @@winner
    end

    def play
        until over? == true
            turn
        end
        if won? != false
            puts "Congratulations #{@@winner}!"
        elsif draw? == true
            puts "Cat's Game!"
        end
    end
end
