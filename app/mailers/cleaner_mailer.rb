class CleanerMailer < ApplicationMailer
  def cleaner_notification(user_a, request)
    @user_a = user_a
    @request = request
    mail(to: @user_a.email, subject: 'Your pokemon trade offer has expired')
  end
end
