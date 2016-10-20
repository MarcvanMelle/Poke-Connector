require 'rails_helper'


feature "User edits and deletes their account" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:rocket) { FactoryGirl.create(:user, email: "TeamRocketTrio@silph.co") }
  let!(:bulbasaur) { Pokemon.create(name: "Bulbasaur", sprite: "bulbsaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
  let!(:pokeball) { Pokeball.create(user: user, pokemon: bulbasaur, level: 20, description: "Gotta catch'em all") }
  let!(:request) { Request.create(user: user, pokemon: bulbasaur, description: "I wanna be the very best") }
  let!(:active_request) { ActiveRequest.create(user: user, request: request) }

  before { login_as(user, scope: :user) }
  before { visit edit_user_registration_path }

  context "User wants to edit their profile" do
    scenario "and clicks the edit profile button on their profile page" do
      visit user_path(user.id)
      click_link("Edit Profile")

      expect(page).to have_content("Email")
      expect(page).to have_field("Email")

      expect(page).to have_content("Password")
      expect(page).to have_field("Password")

      expect(page).to have_content("Password confirmation")
      expect(page).to have_field("Password confirmation")

      expect(page).to have_content("Current password")
      expect(page).to have_field("Current password")

      expect(page).to have_button("Update")
      expect(page).to have_link("Back")

      expect(page).to have_button("Cancel my account")
    end

    scenario "and changes their email" do
      fill_in("Email", with: "garyoak@gmail.com")
      fill_in("Current password", with: user.password)

      click_button("Update")
      expect(page).to have_content("Your account has been updated successfully.")
      expect(User.find(user.id).email).to eq("garyoak@gmail.com")
    end

    scenario "and changes their password" do
      fill_in("Password", with: "garyRule$AshDroolz")
      fill_in("Password confirmation", with: "garyRule$AshDroolz")
      fill_in("Current password", with: user.password)

      old_password = user.encrypted_password

      click_button("Update")
      expect(page).to have_content("Your account has been updated successfully.")
      expect(User.find(user.id).encrypted_password).to_not eq(old_password)
    end

    scenario "and attempts to change their email to an existing user's email" do
      fill_in("Email", with: rocket.email)
      fill_in("Current password", with: user.password)

      click_button("Update")
      expect(page).to have_content("Email has already been taken")
    end

    scenario "and improperly fills in their password confirmation field" do
      fill_in("Password", with: "garyRule$AshDroolz")
      fill_in("Password confirmation", with: "garyRule$AshDrools")
      fill_in("Current password", with: user.password)

      click_button("Update")
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    scenario "and does not fill in current password field" do
      fill_in("Password", with: "garyRule$AshDroolz")
      fill_in("Password confirmation", with: "garyRule$AshDroolz")

      click_button("Update")
      expect(page).to have_content("Current password can't be blank")
    end
  end

  context "User wants to delete their account" do
    scenario "and clicks the cancel account button on their edit profile page" do
      click_button("Cancel my account")

      expect(page).to have_content("Your account has been successfully deleted.")
      expect(User.all.count).to eq(1)
    end
  end
end
