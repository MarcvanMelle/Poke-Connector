class RequestMailer < ApplicationMailer
  def request_notification(user_a, user_b, request, new_trade)
    @user_a = user_a
    @user_b = user_b
    @request = request
    @url = "https://poke-connector.herokuapp.com/requests/#{request.id}"
    @accept = "http://poke-connector.herokuapp.com/active_requests/#{new_trade.id}/accept_request"
    mail(to: @user_a.email, subject: 'You have a new trade request!')
  end
end
