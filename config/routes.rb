Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/games/game_result', to: 'games#game_result'
  get '/games/computer_move', to: 'games#computer_move'

  root 'games#index'
end
