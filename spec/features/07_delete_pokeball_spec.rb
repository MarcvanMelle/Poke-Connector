require 'rails_helper'

feature "User deletes their pokeball" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:rocket) { FactoryGirl.create(:user) }
  let!(:bulbasaur) { Pokemon.create(name: "Bulbasaur", sprite: "bulbasaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
  let!(:ivysaur) { Pokemon.create(name: "Ivysaur", sprite: "ivysaur.gif", pokedex_id: 2, typeA: "poison", typeB: "grass") }
  let!(:pokeball1) { Pokeball.create(user: user, pokemon: bulbasaur, level: 50, description: "Fully EV trained Bulbasaur, competetive moveset.") }
  let!(:pokeball2) { Pokeball.create(user: rocket, pokemon: ivysaur, level: 16, description: "Looking for any of the generation 3 starters", hpIV: 12, attIV: 16, defIV: 29, spaIV: 29, spdIV: 8, speIV: 29) }

  before { login_as(user, scope: :user) }

  context "User visits their offer" do
    scenario "and clicks a delete offer button" do
      visit pokeball_path(pokeball1.id)
      expect(page).to have_link("Delete Offer")
      click_link("Delete Offer")

      expect(page).to have_content("Offer successfully removed.")
      expect(Pokeball.all.count).to eq(1)
    end
  end

  context "User visits another user's offer" do
    scenario "and does not see a delete offer button" do
      visit pokeball_path(pokeball2.id)
      expect(page).to_not have_link("Delete Offer")
    end
  end

  context "User attempts to delete another user's offer via curl" do
    scenario "and is sent a 403 code" do
      page.driver.submit :delete, "/pokeballs/#{pokeball2.id}", {}

      expect(page).to have_content "The page you were looking for is forbidden."
    end
  end
end
