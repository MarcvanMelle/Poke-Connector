require 'rails_helper'

feature "User fails sends a trade request to anothe user if they have already sent a request" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:rocket) { FactoryGirl.create(:user) }
  let!(:bulbasaur) { Pokemon.create(name: "Bulbasaur", sprite: "bulbasaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
  let!(:ivysaur) { Pokemon.create(name: "Ivysaur", sprite: "ivysaur.gif", pokedex_id: 2, typeA: "poison", typeB: "grass") }
  let!(:pokeball1) { Pokeball.create(user: rocket, pokemon: bulbasaur, level: 20, description: "The description doesn't really matter") }
  let!(:request1) { Request.create(user: rocket, pokemon: ivysaur, description: "To meeee~") }
  let!(:pokeball2) { Pokeball.create(user: user, pokemon: bulbasaur, level: 20, description: "The description doesn't really matter") }
  let!(:request2) { Request.create(user: user, pokemon: ivysaur, description: "To meeee~") }
  let!(:active_request) { ActiveRequest.create(user: user, request: request1) }
  let!(:active_pokeball) { ActivePokeball.create(user: user, pokeball: pokeball1) }

  before { login_as(user, scope: :user) }

  context "User navigates to trade mailer via the address bar" do
    scenario "and is redirected to the offer's show page" do
      visit "/users/#{pokeball1.id}/send_trade_mail"
      expect(page).to have_content("You have already sent a trade request for this pokemon")
    end

    scenario "and is redirected to the request's show page" do
      visit "/users/#{request1.id}/request_trade_mail"
      expect(page).to have_content("You have already sent a trade request for this pokemon")
    end
  end

  context "Unauthorized user navigates to trade mailer via the address bar" do
    scenario "and is sent to the log in page" do
      logout(:user)

      visit "/users/#{pokeball1.id}/send_trade_mail"
      expect(page).to have_content("You need to sign in or sign up before continuing.")

      visit "/users/#{request1.id}/request_trade_mail"
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end
end
