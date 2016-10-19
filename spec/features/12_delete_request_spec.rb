require 'rails_helper'

feature "User deletes their request" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:rocket) { FactoryGirl.create(:user) }
  let!(:bulbasaur) { Pokemon.create(name: "Bulbasaur", sprite: "bulbasaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
  let!(:ivysaur) { Pokemon.create(name: "Ivysaur", sprite: "ivysaur.gif", pokedex_id: 2, typeA: "poison", typeB: "grass") }
  let!(:request1) { Request.create(user: user, pokemon: bulbasaur, description: "The description doesn't really matter") }
  let!(:request2) { Request.create(user: rocket, pokemon: ivysaur, description: "To meeeeee~") }

  before { login_as(user, scope: :user) }

  context "User visits their request" do
    scenario "and clicks a delete request button" do
      visit request_path(request1.id)
      expect(page).to have_link("Delete Request")
      click_link("Delete Request")

      expect(page).to have_content("Request successfully removed.")
      expect(Request.all.count).to eq(1)
    end
  end

  context "User visits another user's request" do
    scenario "and does not see a delete request button" do
      visit request_path(request2.id)
      expect(page).to_not have_link("Delete Request")
    end
  end

  context "User attempts to delete another user's request via curl" do
    scenario "and is sent a 403 code" do
      page.driver.submit :delete, "/requests/#{request2.id}", {}

      expect(page).to have_content "The page you were looking for is forbidden."
    end
  end
end
