require 'rails_helper'

feature "User creates request" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:bulbasaur) { Pokemon.create(name: "Bulbasaur", sprite: "bulbasaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
  let!(:ivysaur) { Pokemon.create(name: "Ivysaur", sprite: "ivysaur.gif", pokedex_id: 2, typeA: "poison", typeB: "grass") }

  before { login_as(user, scope: :user) }
  before { visit new_request_path }

  context "User visits homepage" do
    scenario "and clicks request link" do
      visit root_path
      click_link("Request a Pokemon")

      expect(page).to have_content("Description")
      expect(page).to have_field("Description")

      expect(page).to have_button("Submit Request")
    end
  end

  context "User visits new request page" do
    scenario "and successfully submits a new request" do
      select('Ivysaur', from: 'Pokemon')
      fill_in("Description", with: "This is a short description")

      click_button("Submit Request")

      expect(page).to have_content("Pokemon succesfully requested!")
    end

    scenario "and fails to fill in description" do
      select('Ivysaur', from: 'Pokemon')

      click_button("Submit Request")

      expect(page).to have_content("Description can't be blank")
    end
  end
end
