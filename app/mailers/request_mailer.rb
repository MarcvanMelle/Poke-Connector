class RequestMailer < ApplicationMailer
  def request_notification(user_a, user_b, request)
    @user_a = user_a
    @user_b = user_b
    @request = request
    @url = "https://poke-connector.herokuapp.com/requests/#{request.id}"
    @accept = "http://poke-connector.herokuapp.com/users/#{user_b.id}/accept_trade"
    mail(to: @user_a.email, subject: 'You have a new trade request!')
  end
end
