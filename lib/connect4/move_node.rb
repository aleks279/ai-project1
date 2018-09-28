require_relative 'constants.rb'

class ConnectFourMoveNode
  attr_accessor :parent
  attr_accessor :children
  attr_accessor :column
  attr_accessor :value
  attr_accessor :owner
  attr_accessor :player
  attr_accessor :board_state
  attr_accessor :winner

  def initialize(parent, column)
    @parent = parent
    @column = column
  end

  def minimax(depth, maximizing_player)
    if winner
      if maximizing_player
        maximizing_player_id = @owner
      else
        maximizing_player_id = @owner == ConnectFourConstants::PLAYER_ONE ? ConnectFourConstants::PLAYER_TWO : ConnectFourConstants::PLAYER_ONE
      end
      if winner == maximizing_player_id
        return ConnectFourConstants::MAX_VALUE
      elsif winner == ConnectFourConstants::TIE
        return (ConnectFourConstants::MAX_VALUE + ConnectFourConstants::MIN_VALUE) / 2
      else
        return ConnectFourConstants::MIN_VALUE
      end
    end

    return 0 if depth == 0

    if maximizing_player
      best_value = ConnectFourConstants::MAX_VALUE
      children.each do |child|
        child_value = child.minimax(depth - 1, false)
        best_value = [child_value, best_value].min
      end
      return best_value
    else
      best_value = ConnectFourConstants::MIN_VALUE
      children.each do |child|
        child_value = child.minimax(depth - 1, true)
        best_value = [child_value, best_value].max
      end
      return best_value
    end
  end

  def children
    # return the nodes for all valid moves
    return @children unless @children.nil?
    @children = generate_and_return_children
  end

  def winner
    # return 1 if player_one won. return 2 if player_two won. return nil otherwise.
    return @winner unless @winner.nil?
    @winner = determine_winner
  end

  def board_state
    # return an array where 1's represent player_one's moves,
    # 2's represent player_two's moves,
    # and nil represents free spaces
    return @board_state unless @board_state.nil?
    @board_state = generate_and_return_board_state
  end

  def to_s
    { column: @column, owner: @owner }.to_s
  end

  def moves_per_column
    ancestor = parent
    moves_count = Array.new(ConnectFourConstants::COLUMNS, 0)
    until ancestor.nil?
      moves_count[ancestor.column] += 1
      ancestor = ancestor.parent
    end
    moves_count[@column] += 1
    moves_count
  end

  private

  def determine_winner
    winner = nil
    return ConnectFourConstants::TIE if moves_per_column.min == 6
    (0..ConnectFourConstants::COLUMNS - 1).each do |start_column|
      (0..ConnectFourConstants::ROWS - 1).each do |start_row|
        next if board_state[start_column][start_row].nil?
        # NORTH
        if start_row + 3 < ConnectFourConstants::ROWS
          winner = board_state[start_column][start_row] if board_state[start_column][start_row] == board_state[start_column + 0][start_row + 1] && board_state[start_column][start_row] == board_state[start_column + 0][start_row + 2] && board_state[start_column][start_row] == board_state[start_column + 0][start_row + 3]
        end
        # NORTH-EAST
        if start_column + 3 < ConnectFourConstants::COLUMNS && start_row + 3 < ConnectFourConstants::ROWS
          winner = board_state[start_column][start_row] if board_state[start_column][start_row] == board_state[start_column + 1][start_row + 1] && board_state[start_column][start_row] == board_state[start_column + 2][start_row + 2] && board_state[start_column][start_row] == board_state[start_column + 3][start_row + 3]
        end
        # EAST
        if start_column + 3 < ConnectFourConstants::COLUMNS
          winner = board_state[start_column][start_row] if board_state[start_column][start_row] == board_state[start_column + 1][start_row + 0] && board_state[start_column][start_row] == board_state[start_column + 2][start_row + 0] && board_state[start_column][start_row] == board_state[start_column + 3][start_row + 0]
        end
        # SOUTH-EAST
        if start_column + 3 < ConnectFourConstants::COLUMNS && start_row - 3 >= 0
          winner = board_state[start_column][start_row] if board_state[start_column][start_row] == board_state[start_column + 1][start_row - 1] && board_state[start_column][start_row] == board_state[start_column + 2][start_row - 2] && board_state[start_column][start_row] == board_state[start_column + 3][start_row - 3]
        end
        return winner if winner
      end
    end
    nil
  end

  def generate_and_return_board_state
    moves = []
    node = self
    until node.nil?
      moves.unshift(node.column)
      node = node.parent
    end
    board_state = Array.new(ConnectFourConstants::COLUMNS) { Array.new(ConnectFourConstants::ROWS) }
    current_player = ConnectFourConstants::PLAYER_ONE
    moves.each do |move_column|
      y_position = board_state[move_column].index(nil)
      board_state[move_column][y_position] = current_player
      current_player = current_player == ConnectFourConstants::PLAYER_ONE ? ConnectFourConstants::PLAYER_TWO : ConnectFourConstants::PLAYER_ONE
    end
    board_state
  end

  def generate_and_return_children
    return nil unless winner.nil?
    children = []
    moves_per_column.each_with_index do |moves_count, column|
      next unless moves_count < ConnectFourConstants::ROWS
      child = ConnectFourMoveNode.new(self, column)
      child.owner = @owner == ConnectFourConstants::PLAYER_ONE ? ConnectFourConstants::PLAYER_TWO : ConnectFourConstants::PLAYER_ONE
      children.push(child)
    end
    children
  end
end
