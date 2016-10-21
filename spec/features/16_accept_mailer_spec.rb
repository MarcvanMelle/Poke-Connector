require 'rails_helper'

feature "User accepts trade request" do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:bulbasaur) { Pokemon.create(name: "Bulbasaur", sprite: "bulbsaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
  let!(:pokeball) { Pokeball.create(user: user2, pokemon: bulbasaur, level: 20, description: "Gotta catch'em all") }
  let!(:active_pokeball) { ActivePokeball.create(user: user2, pokeball: pokeball) }

  context "User follows link provided by received email" do
    scenario "and sends a confirmation email to the other user" do
      login_as(user1, scope: :user)
      visit accept_trade_user_path(user2.id)
      expect(page).to have_content("Cannot accept trades in dev-mode")
    end
  end
end
