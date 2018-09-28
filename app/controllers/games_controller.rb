class GamesController < ApplicationController
  def game_result
    @moves = params[:moves].split(',')
    connect_four_game = ConnectFourGame.new(@moves)
    @game_result = connect_four_game.game_result
  end

  def computer_move
    @moves = params[:moves].split(',')
    @depth = params[:depth].to_i
    connect_four_game = ConnectFourGame.new(@moves)
    @computer_move = connect_four_game.computer_move(@depth)
  end
end
