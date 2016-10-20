class PokeballMailer < ApplicationMailer
  def pokeball_notification(user_a, user_b, offer)
    @user_a = user_a
    @user_b = user_b
    @pokeball = offer
    @url = "https://poke-connector.herokuapp.com/pokeballs/#{offer.id}"
    @accept = "http://poke-connector.herokuapp.com/users/#{user_b.id}/accept_trade"
    mail(to: @user_a.email, subject: 'You have a new trade request!')
  end
end
