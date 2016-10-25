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

  namespace :api do
    namespace :v1 do
      resources :pokemons, only: [:index]
      resources :pokeballs
      resources :requests
      devise_for :users, controllers: { registations: 'api/v1/registations' }
    end
  end
end
