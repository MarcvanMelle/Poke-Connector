class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def show
    user = User.find(params[:id])
    pokemon = Pokemon.all
    render json: { user: current_user, owner: user, pokeballs: user.pokeballs, requests: user.requests, pokemon: pokemon }
  end

  def edit
    user = User.find(params[:id])
    render json: { user: user }
  end
end
