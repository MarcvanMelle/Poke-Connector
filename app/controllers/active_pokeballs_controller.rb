class ActivePokeballsController < ApplicationController
  def accept_trade
    @user_a = ActivePokeball.find(params[:id]).user
    @user_b = ActivePokeball.find(params[:id]).pokeball.user
    if Rails.env.production?
      AcceptMailer.accept_notification(@user_a, @user_b)
      flash[:success] = "Trade offer accepted"
    else
      flash[:errors] = "Cannot accept trades in dev-mode"
    end
    redirect_to root_path
  end
end
