Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"

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
  resources :active_pokeballs, only: [] do
    member do
      get :accept_trade
    end
  end
  resources :active_requests, only: [] do
    member do
      get :accept_request
    end
  end

  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: { registations: 'api/v1/registations' }
      resources :users, only: [:show]
      resources :pokemons, only: [:index]
      resources :pokeballs do
        get :search
      end
      resources :requests do
        get :search
      end
    end
  end
end
