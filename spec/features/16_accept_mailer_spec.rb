require 'rails_helper'

feature "User accepts trade request" do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:bulbasaur) { Pokemon.create(name: "Bulbasaur", sprite: "bulbsaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
  let!(:ivysaur) { Pokemon.create(name: "Ivysaur", sprite: "ivysaur.gif", pokedex_id: 2, typeA: "poison", typeB: "grass") }
  let!(:pokeball) { Pokeball.create(user: user2, pokemon: bulbasaur, level: 20, description: "Gotta catch'em all") }
  let!(:request) { Request.create(user: user1, pokemon: ivysaur, description: "Pokemon!") }
  let!(:active_pokeball) { ActivePokeball.create(user: user2, pokeball: pokeball) }
  let!(:active_request) { ActiveRequest.create(user: user1, request: request) }

  context "User follows link provided by received email" do
    scenario "and sends a confirmation email to the other user" do
      login_as(user1, scope: :user)
      visit accept_trade_active_pokeball_path(active_pokeball.id)
      expect(page).to have_content("Cannot accept trades in dev-mode")
    end
  end

  context "User follows link provided by received email" do
    scenario "and sends a confirmation email to the other user" do
      login_as(user2, scope: :user)
      visit accept_request_active_request_path(active_request.id)
      expect(page).to have_content("Cannot accept trades in dev-mode")
    end
  end
end
