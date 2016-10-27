class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:home]
  before_action :prevent_dupe_pokeball, only: [:send_trade_mail]
  before_action :prevent_dupe_request, only: [:request_trade_mail]

  def home
  end

  def show
    @user = User.find(params[:id])
  end

  def send_trade_mail
    @user_a = Pokeball.find(params[:id]).user
    @user_b = current_user
    @pokeball = Pokeball.find(params[:id])
    new_trade = ActivePokeball.create(user: @user_b, pokeball: @pokeball)
    if Rails.env.production?
      PokeballMailer.pokeball_notification(@user_a, @user_b, @pokeball, new_trade).deliver_now
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
    new_trade = ActiveRequest.create(user: @user_b, request: @request)
    if Rails.env.production?
      RequestMailer.request_notification(@user_a, @user_b, @pokeball, new_trade).deliver_now
      flash[:success] = "Trade request sent!"
    else
      flash[:errors] = "Cannot Trade in dev-mode(request)."
    end
    ActiveRequest.create(user: @user_b, request: @request)
    redirect_to request_path(@request.id)
  end


  private

  def prevent_dupe_pokeball
    if Pokeball.find(params[:id]).active_pokeballs.find_by(user: current_user)
      flash[:errors] = "You have already sent a trade request for this pokemon" if current_user
      redirect_to pokeball_path(params[:id])
    end
  end

  def prevent_dupe_request
    if Request.find(params[:id]).active_requests.find_by(user: current_user)
      flash[:errors] = "You have already sent a trade request for this pokemon" if current_user
      redirect_to request_path(params[:id])
    end
  end
end
