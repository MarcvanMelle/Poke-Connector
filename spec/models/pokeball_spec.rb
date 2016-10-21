require 'rails_helper'

RSpec.describe Pokeball, type: :model do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:pokemon) { Pokemon.create(name: "Bulbasaur", sprite: "bulbasaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
  let!(:pokeball) { FactoryGirl.create(:pokeball, user: user, pokemon: pokemon, description: "Like no one ever was") }

  describe "#description" do
    it "should return the pokeball's description" do
      expect(pokeball.description).to eq("Like no one ever was")
    end
  end

  describe "#level" do
    it "should return the pokemon in the pokeball's level" do
      expect(pokeball.level).to eq(50)
    end
  end

  describe "#IVs" do
    it "should return the pokemon in the pokeball's IV value for HP" do
      expect(pokeball.hpIV).to eq(0)
    end

    it "should return the pokemon in the pokeball's IV value for Attack" do
      expect(pokeball.attIV).to eq(0)
    end

    it "should return the pokemon in the pokeball's IV value for Defense" do
      expect(pokeball.defIV).to eq(0)
    end

    it "should return the pokemon in the pokeball's IV value for Special Attack" do
      expect(pokeball.spaIV).to eq(0)
    end

    it "should return the pokemon in the pokeball's IV value for Special Defense" do
      expect(pokeball.spdIV).to eq(0)
    end

    it "should return the pokemon in the pokeball's IV value for Speed" do
      expect(pokeball.speIV).to eq(0)
    end
  end
end
