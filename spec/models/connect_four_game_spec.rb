require 'rails_helper'

RSpec.describe 'ConnectFourGame#game_result' do
  it 'returns "1" when the first player wins' do
    game = ConnectFourGame.new([0, 1, 0, 1, 0, 1, 0])
    expect(game.game_result).to eq ConnectFourConstants::PLAYER_ONE
  end
  it 'returns "2" when the second player wins' do
    game = ConnectFourGame.new([0, 1, 2, 1, 4, 1, 6, 1])
    expect(game.game_result).to eq ConnectFourConstants::PLAYER_TWO
  end
  it 'returns "tie" when the game is a tie' do
    game = ConnectFourGame.new([0, 1, 0, 1, 0, 1,
                                2, 3, 2, 3, 2, 3,
                                4, 5, 4, 5, 4, 5,
                                6, 0, 6, 0, 6, 0,
                                1, 2, 1, 2, 1, 2,
                                3, 4, 3, 4, 3, 4,
                                5, 6, 5, 6, 5, 6])
    expect(game.game_result).to eq ConnectFourConstants::TIE
  end
  it 'returns "incomplete" when the game is still in progress' do
    game = ConnectFourGame.new([0, 1])
    expect(game.game_result).to eq 'incomplete'
  end
end
