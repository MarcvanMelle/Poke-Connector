require 'rails_helper'

feature "User Login" do
  let!(:user) { FactoryGirl.create(:user) }
  before { visit new_user_session_path }
  context "Guest visits homepage" do
    scenario "and clicks login link" do
      visit root_path
      click_link("Log In")

      expect(page).to have_content("Email")
      expect(page).to have_field("Email")
      expect(page).to have_content("Password")
      expect(page).to have_field("Password")
      expect(page).to have_button("Log In")
      expect(page).to have_link("Forgot your password?")
      expect(page).to have_link("Sign Up")
      expect(page).to have_content("Remember me")
    end
  end

  context "Guest visits log in" do
    scenario "and fills in the form correctly" do
      fill_in("Email", with: user.email)
      fill_in("Password", with: user.password)
      click_button("Log In")

      expect(page).to have_content("Signed in as #{user.username}")
      expect(page).to_not have_content("Email")
      expect(page).to_not have_field("Email")
      expect(page).to_not have_content("Password")
      expect(page).to_not have_field("Password")
      expect(page).to_not have_button("Log In")
      expect(page).to_not have_link("Forgot your password?")
      expect(page).to_not have_link("Sign Up")
      expect(page).to_not have_content("Remember me")
    end

    scenario "and attempts to log in with an unpersisted email" do
      fill_in("Email", with: "joyLover@pewtergym.com")
      fill_in("Password", with: "<3jennyjennyjenny<3")
      click_button("Log In")

      expect(page).to have_content("Invalid Email or password.")
    end

    scenario "and attempts to log in with an inccorect password" do
      fill_in("Email", with: user.email)
      fill_in("Password", with: "password")
      click_button("Log In")

      expect(page).to have_content("Invalid Email or password.")
    end
  end
end
