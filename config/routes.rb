Rails.application.routes.draw do
  root "users#home"

  devise_for :users
  resources :users, only: [:show]
  resources :pokemons, only: [:index]
  resources :pokeballs
end
