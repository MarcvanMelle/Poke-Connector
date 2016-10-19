require 'rails_helper'

RSpec.describe Request, type: :model do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:pokemon) { Pokemon.create(name: "Bulbasaur", sprite: "bulbasaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
  let!(:request) { Request.create(user: user, pokemon: pokemon, description: "Looking for a Bulbasaur with at least 2 perfect IVs") }

  describe "#description" do
    it "should return the pokeball's description" do
      expect(request.description).to eq("Looking for a Bulbasaur with at least 2 perfect IVs")
    end
  end

  describe "#user" do
    it "should return the request's user" do
      expect(request.user).to eq(user)
    end
  end

  describe "#pokemon" do
    it "should return the request's pokemon" do
      expect(request.pokemon).to eq(pokemon)
    end
  end
end
