class TicTacToe
  attr_accessor :board
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  def initialize()
    @board = Array.new(9, " ")
  end

  def play
    while !over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

  def display_board
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(user_input, token)
    @board[user_input] = token
  end

  def turn
    puts "Please enter 1-9:"
    user_input = gets.strip
    input = input_to_index(user_input)
    if valid_move?(input)
      move(input, current_player)
      display_board
    else
      turn
  end
end

  def valid_move?(user_input)
    if user_input.between?(0,8) && !position_taken?(user_input)
      return true
    end
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def full?
    @board.all?{|token| token == "X" || token == "O"}
  end

  def over?
    won? || draw?
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end



  def won?
    WIN_COMBINATIONS.detect do |combo|
      position(combo[0]) == position(combo[1]) &&
      position(combo[1]) == position(combo[2]) &&
      position_taken?(combo[0])
    end
  end

  def draw?
    !won? && @board.all?{|token| token == "X" || token == "O"}
  end

  def winner
    if winning_combo = won?
      @winner = position(winning_combo.first)
    end
  end

  def position(location)
    @board[location.to_i]
  end

  def position_taken?(location)
    !(position(location).nil? || position(location) == " ")
  end
end
