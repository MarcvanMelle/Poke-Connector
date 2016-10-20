Rails.application.routes.draw do
  root "users#home"

  devise_for :users
  resources :users, only: [:show] do
    member do
      get :send_trade_mail
      get :request_trade_mail
    end
  end
  resources :pokemons, only: [:index]
  resources :pokeballs
  resources :requests
end
