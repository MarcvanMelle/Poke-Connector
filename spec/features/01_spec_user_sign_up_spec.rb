require 'rails_helper'

feature "User Sign-Up" do
  let!(:existing_user) { FactoryGirl.create(:user, username: "James2001", email: "James@rocket.org") }
  before { visit new_user_registration_path }
  context "Guest visits homepage" do
    scenario "and clicks sign up link" do
      visit root_path

      expect(page).to have_link("Sign Up")
      click_link("Sign Up")

      expect(page).to have_content("Sign Up")
      expect(page).to have_content("Username")
      expect(page).to have_field("Username")
      expect(page).to have_content("First Name")
      expect(page).to have_field("First Name")
      expect(page).to have_content("Last Name")
      expect(page).to have_field("Last Name")
      expect(page).to have_content("Email")
      expect(page).to have_field("Email")
      expect(page).to have_content("Password")
      expect(page).to have_field("Password")
      expect(page).to have_content("Password confirmation")
      expect(page).to have_field("Password confirmation")
      expect(page).to have_content("Friend Code")
      expect(page).to have_field("Friend Code")
      expect(page).to have_button("Sign Up")
      expect(page).to have_link("Log In")
    end
  end

  context "Guest visits sign up and" do
    scenario "fills out all fields correctly" do
      fill_in("Username", with: "Jesse2001")
      fill_in("First Name", with: "Jesse")
      fill_in("Last Name", with: "Rocket")
      fill_in("Email", with: "Jesse@rocket.org")
      fill_in("Password", with: "abcedf")
      fill_in("Password confirmation", with: "abcedf")
      fill_in("Friend Code", with: "0000-0000-0000")

      click_button("Sign Up")
      expect(page).to have_content("Signed in as Jesse2001")
    end

    scenario "leaves username blank" do
      fill_in("Username", with: "")
      fill_in("First Name", with: "Jesse")
      fill_in("Last Name", with: "Rocket")
      fill_in("Email", with: "Jesse@rocket.org")
      fill_in("Password", with: "abcedf")
      fill_in("Password confirmation", with: "abcedf")
      fill_in("Friend Code", with: "0000-0000-0000")

      click_button("Sign Up")
      expect(page).to have_content("Username can't be blank")
    end

    scenario "leaves email blank" do
      fill_in("Username", with: "Jesse2001")
      fill_in("First Name", with: "Jesse")
      fill_in("Last Name", with: "Rocket")
      fill_in("Email", with: "")
      fill_in("Password", with: "abcedf")
      fill_in("Password confirmation", with: "abcedf")
      fill_in("Friend Code", with: "0000-0000-0000")

      click_button("Sign Up")
      expect(page).to have_content("Email can't be blank")
    end

    scenario "leaves both password fields blank" do
      fill_in("Username", with: "Jesse2001")
      fill_in("First Name", with: "Jesse")
      fill_in("Last Name", with: "Rocket")
      fill_in("Email", with: "Jesse@rocket.org")
      fill_in("Password", with: "")
      fill_in("Password confirmation", with: "")
      fill_in("Friend Code", with: "0000-0000-0000")

      click_button("Sign Up")
      expect(page).to have_content("Password can't be blank")
    end

    scenario "leaves password confirmation field blank" do
      fill_in("Username", with: "Jesse2001")
      fill_in("First Name", with: "Jesse")
      fill_in("Last Name", with: "Rocket")
      fill_in("Email", with: "Jesse@rocket.org")
      fill_in("Password", with: "abcdef")
      fill_in("Password confirmation", with: "")
      fill_in("Friend Code", with: "0000-0000-0000")

      click_button("Sign Up")
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    scenario "leaves first name field blank" do
      fill_in("Username", with: "Jesse2001")
      fill_in("First Name", with: "")
      fill_in("Last Name", with: "Rocket")
      fill_in("Email", with: "Jesse@rocket.org")
      fill_in("Password", with: "abcdef")
      fill_in("Password confirmation", with: "abcdef")
      fill_in("Friend Code", with: "0000-0000-0000")

      click_button("Sign Up")
      expect(page).to have_content("First name can't be blank")
    end

    scenario "leaves last name field blank" do
      fill_in("Username", with: "Jesse2001")
      fill_in("First Name", with: "Jesse")
      fill_in("Last Name", with: "")
      fill_in("Email", with: "Jesse@rocket.org")
      fill_in("Password", with: "abcdef")
      fill_in("Password confirmation", with: "abcdef")
      fill_in("Friend Code", with: "0000-0000-0000")

      click_button("Sign Up")
      expect(page).to have_content("Last name can't be blank")
    end

    scenario "provides an invalid email" do
      fill_in("Username", with: "Jesse2001")
      fill_in("First Name", with: "Jesse")
      fill_in("Last Name", with: "Rocket")
      fill_in("Email", with: "gomeowth!")
      fill_in("Password", with: "abcdef")
      fill_in("Password confirmation", with: "abcdef")
      fill_in("Friend Code", with: "0000-0000-0000")

      click_button("Sign Up")
      expect(page).to have_content("Email is invalid")
    end

    scenario "provides mismatched passwords" do
      fill_in("Username", with: "Jesse2001")
      fill_in("First Name", with: "Jesse")
      fill_in("Last Name", with: "Rocket")
      fill_in("Email", with: "Jesse@rocket.org")
      fill_in("Password", with: "abcdef")
      fill_in("Password confirmation", with: "abcdef!")
      fill_in("Friend Code", with: "0000-0000-0000")

      click_button("Sign Up")
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    scenario "provides an existing email" do
      fill_in("Username", with: "Jesse2001")
      fill_in("First Name", with: "Jesse")
      fill_in("Last Name", with: "Rocket")
      fill_in("Email", with: "James@rocket.org")
      fill_in("Password", with: "abcdef")
      fill_in("Password confirmation", with: "abcdef")
      fill_in("Friend Code", with: "0000-0000-0000")

      click_button("Sign Up")
      expect(page).to have_content("Email has already been taken")
    end

    scenario "User provides an existing username" do
      fill_in("Username", with: "James2001")
      fill_in("First Name", with: "Jesse")
      fill_in("Last Name", with: "Rocket")
      fill_in("Email", with: "Jesse@rocket.org")
      fill_in("Password", with: "abcdef")
      fill_in("Password confirmation", with: "abcdef")
      fill_in("Friend Code", with: "0000-0000-0000")

      click_button("Sign Up")
      expect(page).to have_content("Username has already been taken")
    end

    scenario "provides a password less than 6 characters" do
      fill_in("Username", with: "Jesse2001")
      fill_in("First Name", with: "Jesse")
      fill_in("Last Name", with: "Rocket")
      fill_in("Email", with: "Jesse@rocket.org")
      fill_in("Password", with: "abcde")
      fill_in("Password confirmation", with: "abcde")
      fill_in("Friend Code", with: "0000-0000-0000")

      click_button("Sign Up")
      expect(page).to have_content("Password is too short (minimum is 6 characters)")
    end
  end
end
