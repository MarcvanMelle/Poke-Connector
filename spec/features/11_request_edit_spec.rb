require 'rails_helper'

feature "User edits their request" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:rocket) { FactoryGirl.create(:user) }
  let!(:bulbasaur) { Pokemon.create(name: "Bulbasaur", sprite: "bulbasaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
  let!(:ivysaur) { Pokemon.create(name: "Ivysaur", sprite: "ivysaur.gif", pokedex_id: 2, typeA: "poison", typeB: "grass") }
  let!(:request1) { Request.create(user: user, pokemon: bulbasaur, description: "The description doesn't matter.") }
  let!(:request2) { Request.create(user: rocket, pokemon: ivysaur, description: "Anyone can see.") }

  before { login_as(user, scope: :user) }
  before { visit edit_request_path(request1.id) }

  context "User visits their own pokemon request page" do
    scenario "and clicks the edit request link" do
      visit request_path(request1.id)
      click_link("Edit Request")

      expect(page).to have_content("Description")
      expect(page).to have_field("Description")

      expect(page).to have_button("Submit Changes")
    end
  end

  context "User visits their request edit page" do
    scenario "and fills in all fields correctly" do
      fill_in("Description", with: "This is my new description")

      click_button("Submit Changes")

      expect(Request.find(request1.id).description).to eq("This is my new description")

      expect(page).to have_content("Request successfully updated!")

      expect(page.find("#request-detail#{request1.id}")).to have_content("Description: #{Request.find(request1.id).description}")
    end

    scenario "and fills in only required fields" do
      fill_in("Description", with: "This is a new description. Yup.")

      click_button("Submit Changes")

      expect(page).to have_content("Request successfully updated!")
    end

    scenario "and fails to fill in description" do
      fill_in("Description", with: "")

      click_button("Submit Changes")

      expect(page).to have_content("Description can't be blank")
    end
  end

  context "User visits another user's request" do
    scenario "and does not see the edit button" do
      visit request_path(request2.id)

      expect(page).to_not have_link("Edit Request")
    end
  end

  context "User tries to navigate to another user's edit request page through the address bar" do
    scenario "and is shown an error message" do
      visit "/requests/2/edit"
      expect(page).to have_content("You may not edit another user's request")
    end
  end
end
