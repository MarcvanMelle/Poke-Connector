class AcceptMailer < ApplicationMailer
  def accept_notification(user_a, user_b)
    @user_a = user_a
    @user_b = user_b
    mail(to: @user_a.email, subject: 'Your trade request was accepted!')
  end
end
