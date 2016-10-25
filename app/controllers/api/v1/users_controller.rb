class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def show
    user = User.find(params[:id])
    render json: { user: user, pokeballs: user.pokeballs, requests: user.requests }
  end
end
