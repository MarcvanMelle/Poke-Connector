require 'rails_helper'

feature "User views pokeball" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:rocket) { FactoryGirl.create(:user) }
  let!(:bulbasaur) { Pokemon.create(name: "Bulbasaur", sprite: "bulbasaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
  let!(:ivysaur) { Pokemon.create(name: "Ivysaur", sprite: "ivysaur.gif", pokedex_id: 2, typeA: "poison", typeB: "grass") }
  let!(:request1) { Request.create(user: user, pokemon: bulbasaur, description: "Looking for a male Dragonite with multiscale.") }
  let!(:request2) { Request.create(user: rocket, pokemon: ivysaur, description: "Looking for any of the generation 3 starters") }

  before { login_as(user, scope: :user) }
  before { visit requests_path }

  context "Guest visits homepage" do
    scenario "and navigates to open requests page" do
      visit root_path
      click_link("All Open Requests")
      expect(page.find("#request#{request1.id}")).to have_content("#{request1.user.username}'s#{request1.pokemon.name} Request")
      expect(page.find("#request-detail#{request1.id}")).to have_content("Description: #{request1.description}")

      expect(page.find("#request#{request2.id}")).to have_content("#{request2.user.username}'s#{request2.pokemon.name}")
      expect(page.find("#request-detail#{request2.id}")).to have_content("Description: #{request2.description}")
    end

    context "User visits requests index" do
      scenario "and clicks a request" do
        expect(page.find("#request-poke-link#{request1.id}")['href']).to eq("/requests/#{request1.id}")
        expect(page.find("#request-poke-link#{request1.id} img")['src']).to eq("/assets/#{request1.pokemon.name.downcase}-4cf0a963e675691114db79051ae80a00b97a8df4c2e72fc6dfb76b7a4dc92ab7.gif")

        visit request_path(request1.id)
        # Faking clicking image link

        expect(page).to_not have_content("All Current Trade Requests")
        expect(page).to have_content("#{request1.user.username}'s Trade Request for #{request1.pokemon.name}")
      end
    end
  end
end
