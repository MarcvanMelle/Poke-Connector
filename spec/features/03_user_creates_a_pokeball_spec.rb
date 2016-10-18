require 'rails_helper'

feature "User creates pokeball" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:bulbasaur) { Pokemon.create(name: "Bulbasaur", sprite: "bulbasaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
  let!(:ivysaur) { Pokemon.create(name: "Ivysaur", sprite: "ivysaur.gif", pokedex_id: 2, typeA: "poison", typeB: "grass") }
  before { login_as(user, scope: :user) }
  before { visit new_pokeball_path}
  context "User visits homepage" do
    scenario "and clicks offer link" do
      visit root_path
      click_link("Offer a Pokemon")

      expect(page).to have_content("Description")
      expect(page).to have_field("Description")
      expect(page).to have_content("Level")
      expect(page).to have_field("Level")

      expect(page).to have_content("HP IV")
      expect(page).to have_field("HP IV")
      expect(page).to have_content("Att IV")
      expect(page).to have_field("Att IV")
      expect(page).to have_content("Def IV")
      expect(page).to have_field("Def IV")
      expect(page).to have_content("SpA IV")
      expect(page).to have_field("SpA IV")
      expect(page).to have_content("SpD IV")
      expect(page).to have_field("SpD IV")
      expect(page).to have_content("Spe IV")
      expect(page).to have_field("Spe IV")

      expect(page).to have_button("Submit Offer")
    end
  end

  context "User visits new pokeball page" do
    scenario "and successfully submits a new pokeball offer" do
      select('Ivysaur', from: 'Pokemon')
      fill_in("Description", with: "This is a short description")
      fill_in("Level", with: 50)
      fill_in("HP IV", with: 21)
      fill_in("Att IV", with: 31)
      fill_in("Def IV", with: 19)
      fill_in("SpA IV", with: 12)
      fill_in("SpD IV", with: 8)
      fill_in("Spe IV", with: 16)

      click_button("Submit Offer")

      expect(page).to have_content("Pokemon succesfully offered!")
    end

    scenario "and fills in only required fields" do
      select('Ivysaur', from: 'Pokemon')
      fill_in("Description", with: "This is a short description")
      fill_in("Level", with: 50)

      click_button("Submit Offer")

      expect(page).to have_content("Pokemon succesfully offered!")
    end

    scenario "and fills in level incorrectly (high)" do
      select('Ivysaur', from: 'Pokemon')
      fill_in("Description", with: "This is a short description")
      fill_in("Level", with: 256)

      click_button("Submit Offer")

      expect(page).to have_content("Level must be less than or equal to 100")
    end

    scenario "and fills in level incorrectly (low)" do
      select('Ivysaur', from: 'Pokemon')
      fill_in("Description", with: "This is a short description")
      fill_in("Level", with: 0)

      click_button("Submit Offer")

      expect(page).to have_content("Level must be greater than or equal to 1")
    end

    scenario "and fails to fill in level" do
      select('Ivysaur', from: 'Pokemon')
      fill_in("Description", with: "This is a short description")

      click_button("Submit Offer")

      expect(page).to have_content("Level can't be blank")
    end

    scenario "and fails to fill in description" do
      select('Ivysaur', from: 'Pokemon')
      fill_in("Level", with: 0)

      click_button("Submit Offer")

      expect(page).to have_content("Description can't be blank")
    end

    scenario "and fills in the IV fields incorrectly (high)" do
      select('Ivysaur', from: 'Pokemon')
      fill_in("Description", with: "This is a short description")
      fill_in("Level", with: 50)
      fill_in("HP IV", with: 32)
      fill_in("Att IV", with: 32)
      fill_in("Def IV", with: 32)
      fill_in("SpA IV", with: 32)
      fill_in("SpD IV", with: 32)
      fill_in("Spe IV", with: 32)

      click_button("Submit Offer")

      expect(page).to have_content("Hpiv must be less than or equal to 31")
      expect(page).to have_content("Attiv must be less than or equal to 31")
      expect(page).to have_content("Defiv must be less than or equal to 31")
      expect(page).to have_content("Spaiv must be less than or equal to 31")
      expect(page).to have_content("Spdiv must be less than or equal to 31")
      expect(page).to have_content("Speiv must be less than or equal to 31")
    end

    scenario "and fills in the IV fields incorrectly (low)" do
      select('Ivysaur', from: 'Pokemon')
      fill_in("Description", with: "This is a short description")
      fill_in("Level", with: 50)
      fill_in("HP IV", with: -1)
      fill_in("Att IV", with: -1)
      fill_in("Def IV", with: -1)
      fill_in("SpA IV", with: -1)
      fill_in("SpD IV", with: -1)
      fill_in("Spe IV", with: -1)

      click_button("Submit Offer")

      expect(page).to have_content("Hpiv must be greater than or equal to 0")
      expect(page).to have_content("Attiv must be greater than or equal to 0")
      expect(page).to have_content("Defiv must be greater than or equal to 0")
      expect(page).to have_content("Spaiv must be greater than or equal to 0")
      expect(page).to have_content("Spdiv must be greater than or equal to 0")
      expect(page).to have_content("Speiv must be greater than or equal to 0")
    end
  end
end
