class PokeballMailer < ApplicationMailer
  def pokeball_notification(userA, userB, offer)
    @userA = userA
    @userB = userB
    @pokeball = offer
    @url  = "https://poke-connector.herokuapp.com/pokeballs/#{offer.id}"
    mail(to: @userA.email, subject: 'You have a new trade request!')
  end
end
