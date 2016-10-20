class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def home
  end

  def show
    @user = User.find(params[:id])
  end

  def send_trade_mail
    @user_a = Pokeball.find(params[:id]).user
    @user_b = current_user
    @pokeball = Pokeball.find(params[:id])
    if Rails.env.production?
      PokeballMailer.pokeball_notifcation(@user_a, @user_b, @pokeball).deliver_now
      flash[:success] = "Trade request sent!"
    else
      flash[:errors] = "Cannot Trade in dev-mode(pokeball)."
    end
    redirect_to pokeball_path(@pokeball.id)
  end

  def request_trade_mail
    @user_a = Request.find(params[:id]).user
    @user_b = current_user
    @request = Request.find(params[:id])
    if Rails.env.production?
      RequestMailer.request_notifcation(@user_a, @user_b, @pokeball).deliver_now
      flash[:success] = "Trade request sent!"
    else
      flash[:errors] = "Cannot Trade in dev-mode(request)."
    end
    redirect_to request_path(@request.id)
  end
end
