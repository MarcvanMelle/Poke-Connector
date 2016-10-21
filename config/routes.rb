Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"

  root "users#home"

  devise_for :users
  resources :users, only: [:show] do
    member do
      get :send_trade_mail
      get :request_trade_mail
      get :accept_trade
    end
  end

  resources :pokemons, only: [:index]
  resources :pokeballs
  resources :requests
end
