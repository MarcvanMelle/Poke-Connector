require 'rails_helper'

feature "User edits their pokeball" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:rocket) { FactoryGirl.create(:user) }
  let!(:bulbasaur) { Pokemon.create(name: "Bulbasaur", sprite: "bulbasaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
  let!(:ivysaur) { Pokemon.create(name: "Ivysaur", sprite: "ivysaur.gif", pokedex_id: 2, typeA: "poison", typeB: "grass") }
  let!(:pokeball1) { Pokeball.create(user: user, pokemon: bulbasaur, level: 50, description: "Fully EV trained Bulbasaur, competetive moveset.") }
  let!(:pokeball2) { Pokeball.create(user: rocket, pokemon: ivysaur, level: 16, description: "Looking for any of the generation 3 starters", hpIV: 12, attIV: 16, defIV: 29, spaIV: 29, spdIV: 8, speIV: 29) }

  before { login_as(user, scope: :user) }
  before { visit edit_pokeball_path(pokeball1.id) }

  context "User visits their own pokemon offer page" do
    scenario "and clicks the edit offer link" do
      visit pokeball_path(pokeball1.id)
      click_link("Edit Offer")

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

      expect(page).to have_button("Submit Changes")
    end
  end

  context "User visits their offer edit page" do
    scenario "and fills in all fields correctly" do
      fill_in("Description", with: "This is my new description")
      fill_in("Level", with: 13)
      fill_in("HP IV", with: 25)
      fill_in("Att IV", with: 29)
      fill_in("Def IV", with: 28)
      fill_in("SpA IV", with: 26)
      fill_in("SpD IV", with: 14)
      fill_in("Spe IV", with: 30)

      click_button("Submit Changes")

      expect(Pokeball.find(pokeball1.id).level).to eq(13)
      expect(Pokeball.find(pokeball1.id).hpIV).to eq(25)
      expect(Pokeball.find(pokeball1.id).attIV).to eq(29)
      expect(Pokeball.find(pokeball1.id).defIV).to eq(28)
      expect(Pokeball.find(pokeball1.id).spaIV).to eq(26)
      expect(Pokeball.find(pokeball1.id).spdIV).to eq(14)
      expect(Pokeball.find(pokeball1.id).speIV).to eq(30)
      expect(Pokeball.find(pokeball1.id).description).to eq("This is my new description")

      expect(page).to have_content("Offer successfully updated!")

      expect(page.find("#offer#{pokeball1.id}")).to have_content("#{pokeball1.user.username}'s #{Pokeball.find(pokeball1.id).pokemon.name}")
      expect(page.find("#offer-detail#{pokeball1.id}")).to have_content("Level: #{Pokeball.find(pokeball1.id).level}")
      expect(page.find("#offer-detail#{pokeball1.id}")).to have_content("HP: #{Pokeball.find(pokeball1.id).hpIV}")
      expect(page.find("#offer-detail#{pokeball1.id}")).to have_content("Atk: #{Pokeball.find(pokeball1.id).attIV}")
      expect(page.find("#offer-detail#{pokeball1.id}")).to have_content("Def: #{Pokeball.find(pokeball1.id).defIV}")
      expect(page.find("#offer-detail#{pokeball1.id}")).to have_content("SpA: #{Pokeball.find(pokeball1.id).spaIV}")
      expect(page.find("#offer-detail#{pokeball1.id}")).to have_content("SpD: #{Pokeball.find(pokeball1.id).spdIV}")
      expect(page.find("#offer-detail#{pokeball1.id}")).to have_content("Spe: #{Pokeball.find(pokeball1.id).speIV}")
      expect(page.find("#offer-detail#{pokeball1.id}")).to have_content("Description: #{Pokeball.find(pokeball1.id).description}")
    end

    scenario "and fills in only required fields" do
      fill_in("Description", with: "This is a new description. Yup.")
      fill_in("Level", with: 12)

      click_button("Submit Changes")

      expect(page).to have_content("Offer successfully updated!")
    end

    scenario "and fills in level incorrectly (high)" do
      fill_in("Description", with: "This is a new description. Yup.")
      fill_in("Level", with: 256)

      click_button("Submit Changes")

      expect(page).to have_content("Level must be less than or equal to 100")
    end

    scenario "and fills in level incorrectly (low)" do
      fill_in("Description", with: "This is a new description. Yup.")
      fill_in("Level", with: 0)

      click_button("Submit Changes")

      expect(page).to have_content("Level must be greater than or equal to 1")
    end

    scenario "and fails to fill in level" do
      fill_in("Description", with: "This is a short description")

      click_button("Submit Changes")

      expect(page).to have_content("Level can't be blank")
    end

    scenario "and fails to fill in description" do
      fill_in("Level", with: 1)

      click_button("Submit Changes")

      expect(page).to have_content("Description can't be blank")
    end

    scenario "and fills in the IV fields incorrectly (high)" do
      fill_in("Description", with: "This is a new description. Yup.")
      fill_in("Level", with: 50)
      fill_in("HP IV", with: 32)
      fill_in("Att IV", with: 32)
      fill_in("Def IV", with: 32)
      fill_in("SpA IV", with: 32)
      fill_in("SpD IV", with: 32)
      fill_in("Spe IV", with: 32)

      click_button("Submit Changes")

      expect(page).to have_content("Hpiv must be less than or equal to 31")
      expect(page).to have_content("Attiv must be less than or equal to 31")
      expect(page).to have_content("Defiv must be less than or equal to 31")
      expect(page).to have_content("Spaiv must be less than or equal to 31")
      expect(page).to have_content("Spdiv must be less than or equal to 31")
      expect(page).to have_content("Speiv must be less than or equal to 31")
    end

    scenario "and fills in the IV fields incorrectly (low)" do
      fill_in("Description", with: "This is a new description. Yup.")
      fill_in("Level", with: 50)
      fill_in("HP IV", with: -1)
      fill_in("Att IV", with: -1)
      fill_in("Def IV", with: -1)
      fill_in("SpA IV", with: -1)
      fill_in("SpD IV", with: -1)
      fill_in("Spe IV", with: -1)

      click_button("Submit Changes")

      expect(page).to have_content("Hpiv must be greater than or equal to 0")
      expect(page).to have_content("Attiv must be greater than or equal to 0")
      expect(page).to have_content("Defiv must be greater than or equal to 0")
      expect(page).to have_content("Spaiv must be greater than or equal to 0")
      expect(page).to have_content("Spdiv must be greater than or equal to 0")
      expect(page).to have_content("Speiv must be greater than or equal to 0")
    end
  end

  context "User visits another user's offer" do
    scenario "and does not see the edit button" do
      visit pokeball_path(pokeball2.id)

      expect(page).to_not have_link("Edit Offer")
    end
  end

  context "User tries to navigate to another user's edit offer page through the address bar" do
    scenario "and is shown an 403 error page" do
      visit "/pokeballs/2/edit"
      expect(page).to have_content("You may not edit another user's offer")
    end
  end
end
