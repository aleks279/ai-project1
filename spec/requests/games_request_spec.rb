require 'rails_helper'

RSpec.describe 'GamesController#game_result', type: :request do
  it 'returns json' do
    moves = [0, 1, 0, 1, 0, 1, 0]

    get games_game_result_url(format: :json, moves: moves.join(','))

    expect(response.content_type).to eq('application/json')
  end
  it 'returns the "moves" param' do
    moves = [0, 1, 0, 1, 0, 1, 0]

    get games_game_result_url(format: :json, moves: moves.join(','))

    parsed_response = JSON.parse(response.body)
    expect(parsed_response['moves'].length).to be == moves.length
  end
  it 'returns "1" when the first player wins' do
    moves = [0, 1, 0, 1, 0, 1, 0]

    get games_game_result_url(format: :json, moves: moves.join(','))

    parsed_response = JSON.parse(response.body)
    expect(parsed_response['game_result']).to be == '1'
  end
  it 'returns "2" when the second player wins' do
    moves = [0, 1, 2, 1, 0, 1, 2, 1]

    get games_game_result_url(format: :json, moves: moves.join(','))

    parsed_response = JSON.parse(response.body)
    expect(parsed_response['game_result']).to be == '2'
  end
  it 'returns "incomplete" when the game is still in progress' do
    moves = [0, 1]

    get games_game_result_url(format: :json, moves: moves.join(','))

    parsed_response = JSON.parse(response.body)
    expect(parsed_response['game_result']).to be == 'incomplete'
  end
  it 'returns "tie" when the game is tied' do
    moves = [0, 1, 0, 1, 0, 1,
             2, 3, 2, 3, 2, 3,
             4, 5, 4, 5, 4, 5,
             6, 0, 6, 0, 6, 0,
             1, 2, 1, 2, 1, 2,
             3, 4, 3, 4, 3, 4,
             5, 6, 5, 6, 5, 6]

    get games_game_result_url(format: :json, moves: moves.join(','))

    parsed_response = JSON.parse(response.body)
    expect(parsed_response['game_result']).to be == 'tie'
  end
end

RSpec.describe 'GamesController#computer_move', type: :request do
  it 'returns json' do
    moves = [0, 1, 0, 1, 0, 1]

    get games_computer_move_url(format: :json, moves: moves.join(','), depth: 2)

    expect(response.content_type).to eq('application/json')
  end
  it 'returns the "moves" param' do
    moves = [0, 1, 0, 1, 0, 1]

    get games_computer_move_url(format: :json, moves: moves.join(','), depth: 2)

    parsed_response = JSON.parse(response.body)
    expect(parsed_response['moves'].length).to be == moves.length
  end
  it 'returns the "depth" param' do
    moves = [0, 1, 0, 1, 0, 1]
    depth = 3

    get games_computer_move_url(format: :json, moves: moves.join(','), depth: depth)

    parsed_response = JSON.parse(response.body)
    expect(parsed_response['depth']).to be == depth
  end
  it 'makes the winning move' do
    moves = [0, 1, 0, 1, 0, 1]

    get games_computer_move_url(format: :json, moves: moves.join(','), depth: 2)

    parsed_response = JSON.parse(response.body)
    expect(parsed_response['computer_move']).to be == 0
  end
  it "blocks the opponent's winning move" do
    moves = [0, 6, 0, 1, 0]

    get games_computer_move_url(format: :json, moves: moves.join(','), depth: 2)

    parsed_response = JSON.parse(response.body)
    expect(parsed_response['computer_move']).to be == 0
  end
end
