require 'rails_helper'

feature "User views profile" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:rocket) { FactoryGirl.create(:user) }
  let!(:bulbasaur) { Pokemon.create(name: "Bulbasaur", sprite: "bulbasaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
  let!(:ivysaur) { Pokemon.create(name: "Ivysaur", sprite: "ivysaur.gif", pokedex_id: 2, typeA: "poison", typeB: "grass") }
  let!(:pokeball1) { Pokeball.create(user: user, pokemon: bulbasaur, level: 50, description: "Fully EV trained Bulbasaur, competetive moveset.") }
  let!(:pokeball2) { Pokeball.create(user: rocket, pokemon: ivysaur, level: 16, description: "Looking for any of the generation 3 starters", hpIV: 12, attIV: 16, defIV: 29, spaIV: 29, spdIV: 8, speIV: 29) }

  context "Unauthenticated user visits user page" do
    scenario "and is redirected to log in" do
      visit user_path(user.id)
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end

  context "Authenticated user visits their own user page" do
    scenario "and can view their vital statistics" do
      login_as(user, scope: :user)
      visit user_path(user.id)
      expect(page).to have_content("#{user.username}'s Profile")
      expect(page).to have_content("#{user.username}'s Profile")
      expect(page.find(".offer#{pokeball1.id}")).to have_content("#{user.username}'s #{pokeball1.pokemon.name}")
    end
  end

  context "Authenticated user visits another user's page" do
    scenario "and can view their vital statistics" do
      login_as(user, scope: :user)
      visit user_path(rocket.id)
      expect(page).to have_content("#{rocket.username}'s Profile")
      expect(page.find(".offer#{pokeball2.id}")).to have_content("#{rocket.username}'s #{pokeball2.pokemon.name}")
    end
  end
end
