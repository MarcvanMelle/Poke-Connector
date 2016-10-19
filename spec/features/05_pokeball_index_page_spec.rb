require 'rails_helper'

feature "User views pokeball" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:rocket) { FactoryGirl.create(:user) }
  let!(:bulbasaur) { Pokemon.create(name: "Bulbasaur", sprite: "bulbasaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
  let!(:ivysaur) { Pokemon.create(name: "Ivysaur", sprite: "ivysaur.gif", pokedex_id: 2, typeA: "poison", typeB: "grass") }
  let!(:pokeball1) { Pokeball.create(user: user, pokemon: bulbasaur, level: 50, description: "Fully EV trained Bulbasaur, competetive moveset.") }
  let!(:pokeball2) { Pokeball.create(user: rocket, pokemon: ivysaur, level: 16, description: "Looking for any of the generation 3 starters", hpIV: 12, attIV: 16, defIV: 29, spaIV: 29, spdIV: 8, speIV: 29) }

  before { login_as(user, scope: :user) }
  before { visit pokeballs_path }

  context "Guest visits homepage" do
    scenario "and navigates to open offers page" do
      visit root_path
      click_link("All Open Offers")
      expect(page.find("#offer#{pokeball1.id}")).to have_content("#{pokeball1.user.username}'s #{pokeball1.pokemon.name}")
      expect(page.find("#offer-detail#{pokeball1.id}")).to have_content("Level: #{pokeball1.level}")
      expect(page.find("#offer-detail#{pokeball1.id}")).to have_content("HP: ?")
      expect(page.find("#offer-detail#{pokeball1.id}")).to have_content("Atk: ?")
      expect(page.find("#offer-detail#{pokeball1.id}")).to have_content("Def: ?")
      expect(page.find("#offer-detail#{pokeball1.id}")).to have_content("SpA: ?")
      expect(page.find("#offer-detail#{pokeball1.id}")).to have_content("SpD: ?")
      expect(page.find("#offer-detail#{pokeball1.id}")).to have_content("Spe: ?")
      expect(page.find("#offer-detail#{pokeball1.id}")).to have_content("Description: #{pokeball1.description}")

      expect(page.find("#offer#{pokeball2.id}")).to have_content("#{pokeball2.user.username}'s #{pokeball2.pokemon.name}")
      expect(page.find("#offer-detail#{pokeball2.id}")).to have_content("Level: #{pokeball2.level}")
      expect(page.find("#offer-detail#{pokeball2.id}")).to have_content("HP: #{pokeball2.hpIV}")
      expect(page.find("#offer-detail#{pokeball2.id}")).to have_content("Atk: #{pokeball2.attIV}")
      expect(page.find("#offer-detail#{pokeball2.id}")).to have_content("Def: #{pokeball2.defIV}")
      expect(page.find("#offer-detail#{pokeball2.id}")).to have_content("SpA: #{pokeball2.spaIV}")
      expect(page.find("#offer-detail#{pokeball2.id}")).to have_content("SpD: #{pokeball2.spdIV}")
      expect(page.find("#offer-detail#{pokeball2.id}")).to have_content("Spe: #{pokeball2.speIV}")
      expect(page.find("#offer-detail#{pokeball2.id}")).to have_content("Description: #{pokeball2.description}")
    end

    context "User visits offers index" do
      scenario "and clicks an offer" do
        expect(page.find("#poke-link#{pokeball1.id}")['href']).to eq("/pokeballs/#{pokeball1.id}")
        expect(page.find("#poke-link#{pokeball1.id} img")['src']).to eq("/assets/#{pokeball1.pokemon.name.downcase}-4cf0a963e675691114db79051ae80a00b97a8df4c2e72fc6dfb76b7a4dc92ab7.gif")

        visit pokeball_path(pokeball1.id)
        # Faking clicking image link

        expect(page).to_not have_content("All Current Trade Offers")
        expect(page).to have_content("#{pokeball1.user.username}'s Trade Offer for #{pokeball1.pokemon.name}")
        expect(page).to have_content("#{pokeball1.user.username}'s #{pokeball1.pokemon.name}")
      end
    end
  end
end
