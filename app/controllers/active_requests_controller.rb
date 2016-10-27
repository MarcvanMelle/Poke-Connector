class ActiveRequestsController < ApplicationController
  def accept_request
    @user_a = ActiveRequest.find(params[:id]).user
    @user_b = ActiveRequest.find(params[:id]).request.user
    if Rails.env.production?
      AcceptMailer.accept_notification(@user_a, @user_b).deliver_now
      flash[:success] = "Trade offer accepted"
    else
      flash[:errors] = "Cannot accept trades in dev-mode"
    end
    redirect_to root_path
  end
end
