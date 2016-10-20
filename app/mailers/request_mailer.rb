class RequestMailer < ApplicationMailer
  def request_notification(userA, userB, request)
    @userA = userA
    @userB = userB
    @request = request
    @url  = "https://poke-connector.herokuapp.com/requests/#{request.id}"
    mail(to: @userA.email, subject: 'You have a new trade request!')
  end
end
