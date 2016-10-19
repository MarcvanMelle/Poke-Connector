class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def home
  end

  def show
    @user = User.find(params[:id])
  end
end
