require_relative 'move_node.rb'
require_relative 'constants.rb'

class ConnectFourMoveTree
  attr_accessor :root
  attr_accessor :last_move
  attr_accessor :player_to_move

  def initialize
    @player_to_move = ConnectFourConstants::PLAYER_ONE
  end

  def load_game(moves)
    @root = nil
    moves.each_with_index do |move, index|
      make_move(move)
    end
  end

  def export_game
    node = @last_move
    moves = Array.new
    while !node.nil?
      moves.push(node.column)
      node = node.parent
    end
    return moves.reverse
  end

  def make_move(column)
  	column = 'c' if column == ''
  	if column =~ /c(\d*)/
  		depth = $1
  		depth = 4 if depth == ''
  		depth = depth.to_i
  		column = ai_choose_column(depth)
  	else
  		column = column.to_i
  	end
    if (column < 0) || (column >= ConnectFourConstants::COLUMNS)
      raise "columns must be between 0 and #{ConnectFourConstants::COLUMNS - 1}"
    end
    if @last_move.nil?
      @root = ConnectFourMoveNode.new(nil, column)
      @last_move = @root
    else
      if @last_move.moves_per_column[column] >= ConnectFourConstants::ROWS
        raise "column overflow"
      end
      @last_move.children.each do |child|
        if child.column == column
          @last_move = child
          break
        end
      end
    end
    @last_move.owner = @player_to_move
    @player_to_move = (@player_to_move == ConnectFourConstants::PLAYER_ONE) ? ConnectFourConstants::PLAYER_TWO : ConnectFourConstants::PLAYER_ONE
    return column
  end

  def ai_choose_column(depth)
  	if @root.nil?
  		return [0, 1, 2, 3, 4, 5, 6].sample
  	end
  	max_score = ConnectFourConstants::MIN_VALUE
  	column_score_pairs = Array.new
  	last_move.children&.each do |child|
  		column = child.column
  		score = child.minimax(depth, true)
  		max_score = [score, max_score].max
			column_score_pairs.push({ column: column, score: score })
  	end
  	return column_score_pairs.select {|pair| pair[:score] == max_score}.sample[:column]
  end

  def to_s
    string = ""
    (ConnectFourConstants::ROWS-1).step(0, -1) do |row|
      (0..ConnectFourConstants::COLUMNS-1).each do |column|
      	if @last_move.nil?
          string += " ."
        elsif @last_move.board_state[column][row].nil?
          string += " ."
        else
          string += " " + @last_move.board_state[column][row]
        end
      end
      string += "\n"
    end
    string += "---------------\n"
    string += " 0 1 2 3 4 5 6"
    return string
  end

  def winner
    @last_move&.winner
  end
end
