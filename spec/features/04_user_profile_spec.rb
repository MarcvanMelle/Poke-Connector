require 'rails_helper'

feature "User views profile" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:rocket) { FactoryGirl.create(:user) }
  let!(:bulbasaur) { Pokemon.create(name: "Bulbasaur", sprite: "bulbasaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
  let!(:ivysaur) { Pokemon.create(name: "Ivysaur", sprite: "ivysaur.gif", pokedex_id: 2, typeA: "poison", typeB: "grass") }
  let!(:pokeball1) { Pokeball.create(user: user, pokemon: bulbasaur, level: 50, description: "Fully EV trained Bulbasaur, competetive moveset.") }
  let!(:pokeball2) { Pokeball.create(user: rocket, pokemon: ivysaur, level: 16, description: "Looking for any of the generation 3 starters", hpIV: 12, attIV: 16, defIV: 29, spaIV: 29, spdIV: 8, speIV: 29) }
  let!(:request1) { Request.create(user: user, pokemon: ivysaur, description: "Looking for a Wartortle") }
  let!(:request2) { Request.create(user: rocket, pokemon: bulbasaur, description: "Looking for a Charmeleon") }

  context "Unauthenticated user visits user page" do
    scenario "and is redirected to log in" do
      visit user_path(user.id)
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end

  context "Authenticated user visits their own user page" do
    scenario "and can view their offered pokemon" do
      login_as(user, scope: :user)
      visit user_path(user.id)
      expect(page).to have_content("#{user.username}'s Profile")
      expect(page.find("#offer#{pokeball1.id}")).to have_content("#{user.username}'s #{pokeball1.pokemon.name}")
    end

    scenario "and can view their requested pokemon" do
      login_as(user, scope: :user)
      visit user_path(user.id)

      expect(page).to have_content("#{user.username}'s Profile")
      expect(page.find("#request#{request1.id}")).to have_content("#{user.username}'s #{request1.pokemon.name}")
    end

    scenario "and can click on their offer link to see their offer" do
      login_as(user, scope: :user)
      visit user_path(user.id)
      expect(page.find("#offer-poke-link#{pokeball1.id}")['href']).to eq("/pokeballs/#{pokeball1.id}")

      visit pokeball_path(pokeball1.id)
      # Faking click on image link

      expect(page).to have_content("#{pokeball1.user.username}'s Trade Offer for #{pokeball1.pokemon.name}")
    end

    scenario "and can click on their request link to see their request" do
      login_as(user, scope: :user)
      visit user_path(user.id)
      expect(page.find("#request-poke-link#{request1.id}")['href']).to eq("/requests/#{request1.id}")

      visit request_path(request1.id)
      # Faking click on image link

      expect(page).to have_content("#{request1.user.username}'s Trade Request for #{request1.pokemon.name}")
    end
  end

  context "Authenticated user visits another user's page" do
    scenario "and can view their offered pokemon" do
      login_as(user, scope: :user)
      visit user_path(rocket.id)

      expect(page).to have_content("#{rocket.username}'s Profile")
      expect(page.find("#offer#{pokeball2.id}")).to have_content("#{rocket.username}'s #{pokeball2.pokemon.name}")
    end

    scenario "and can view their requested pokemon" do
      login_as(user, scope: :user)
      visit user_path(rocket.id)

      expect(page).to have_content("#{rocket.username}'s Profile")
      expect(page.find("#request#{request2.id}")).to have_content("#{rocket.username}'s #{request2.pokemon.name}")
    end

    scenario "and can click on that user's offer link to see their offer" do
      login_as(user, scope: :user)
      visit user_path(rocket.id)
      expect(page.find("#offer-poke-link#{pokeball2.id}")['href']).to eq("/pokeballs/#{pokeball2.id}")

      visit pokeball_path(pokeball2.id)
      # Faking click on image link

      expect(page).to have_content("#{pokeball2.user.username}'s Trade Offer for #{pokeball2.pokemon.name}")
    end

    scenario "and can click on that user's request link to see their request" do
      login_as(user, scope: :user)
      visit user_path(rocket.id)
      expect(page.find("#request-poke-link#{request2.id}")['href']).to eq("/requests/#{request2.id}")

      visit request_path(request2.id)
      # Faking click on image link

      expect(page).to have_content("#{request2.user.username}'s Trade Request for #{request2.pokemon.name}")
    end
  end
end
