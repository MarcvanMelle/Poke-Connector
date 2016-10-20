require 'rails_helper'

feature "User sends a trade request to anothe user" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:rocket) { FactoryGirl.create(:user) }
  let!(:bulbasaur) { Pokemon.create(name: "Bulbasaur", sprite: "bulbasaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
  let!(:ivysaur) { Pokemon.create(name: "Ivysaur", sprite: "ivysaur.gif", pokedex_id: 2, typeA: "poison", typeB: "grass") }
  let!(:pokeball1) { Pokeball.create(user: rocket, pokemon: bulbasaur, level: 20, description: "The description doesn't really matter") }
  let!(:request1) { Request.create(user: rocket, pokemon: ivysaur, description: "To meeee~") }
  let!(:pokeball2) { Pokeball.create(user: user, pokemon: bulbasaur, level: 20, description: "The description doesn't really matter") }
  let!(:request2) { Request.create(user: user, pokemon: ivysaur, description: "To meeee~") }

  before { login_as(user, scope: :user) }

  context "User visits another user's open offer" do
    scenario "and clicks the send trade request button" do
      visit pokeball_path(pokeball1.id)
      expect(page).to have_link("Send Trade Request")
      click_link("Send Trade Request")

      expect(page).to have_content("Cannot Trade in dev-mode(pokeball).")
    end
  end

  context "User visits another user's open request" do
    scenario "and clicks the send trade request button" do
      visit request_path(request1.id)
      expect(page).to have_link("Send Trade Request")
      click_link("Send Trade Request")

      expect(page).to have_content("Cannot Trade in dev-mode(request).")
    end
  end

  context "User visits their own open offer" do
    scenario "and cannot trade with themselves" do
      visit pokeball_path(pokeball2.id)
      expect(page).to_not have_link("Send Trade Request")

      expect(page).to have_content("You cannot request to trade with yourself.")
    end
  end

  context "User visits their own open request" do
    scenario "and cannot trade with themselves" do
      visit request_path(request2.id)
      expect(page).to_not have_link("Send Trade Request")

      expect(page).to have_content("You cannot request to trade with yourself.")
    end
  end

  context "Unauthorized user visits an open offer" do
    scenario "and cannot trade with themselves" do
      logout(:user)
      visit pokeball_path(pokeball1.id)
      expect(page).to_not have_link("Send Trade Request")

      expect(page).to have_link("You must be logged in to request a trade")
    end
  end

  context "Unauthorized user visits an open request" do
    scenario "and cannot trade with themselves" do
      logout(:user)
      visit request_path(request1.id)
      expect(page).to_not have_link("Send Trade Request")

      expect(page).to have_link("You must be logged in to request a trade")
    end
  end
end
