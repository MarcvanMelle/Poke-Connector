require 'rails_helper'

RSpec.describe CleanerWorker, type: :worker do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:pokemon) { Pokemon.create(name: "Bulbasaur", sprite: "bulbasaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
  let!(:pokeball1) { FactoryGirl.create(:pokeball, user: user, pokemon: pokemon, created_at: DateTime.now - 18) }
  let!(:pokeball2) { FactoryGirl.create(:pokeball, user: user, pokemon: pokemon, created_at: DateTime.now - 13) }
  let!(:pokeball3) { FactoryGirl.create(:pokeball, user: user, pokemon: pokemon, created_at: DateTime.now - 17) }
  let!(:pokeball4) { FactoryGirl.create(:pokeball, user: user, pokemon: pokemon, created_at: DateTime.now - 6) }
  let!(:request1) { Request.create(user: user, pokemon: pokemon, description: "Yup", created_at: DateTime.now - 18) }
  let!(:request2) { Request.create(user: user, pokemon: pokemon, description: "Yup", created_at: DateTime.now - 13) }
  let!(:request3) { Request.create(user: user, pokemon: pokemon, description: "Yup", created_at: DateTime.now - 17) }
  let!(:request4) { Request.create(user: user, pokemon: pokemon, description: "Yup", created_at: DateTime.now - 15) }
  let!(:active_offer1) { ActivePokeball.create(user: user2, pokeball: pokeball1) }
  let!(:active_offer2) { ActivePokeball.create(user: user2, pokeball: pokeball2) }
  let!(:active_offer3) { ActivePokeball.create(user: user2, pokeball: pokeball3) }
  let!(:active_offer4) { ActiveRequest.create(user: user2, request: request1) }
  let!(:active_offer5) { ActiveRequest.create(user: user2, request: request2) }
  let!(:active_offer6) { ActiveRequest.create(user: user2, request: request3) }

  describe "#perform" do
    it "Removes all offers older than 2 weeks, leaves offers newer than 2 weeks" do
      worker = CleanerWorker.new
      expect(Request.all.count).to eq(4)
      expect(Pokeball.all.count).to eq(4)

      worker.perform

      expect(Request.all.count).to eq(1)
      expect(Pokeball.all.count).to eq(2)
    end

    it "Removes all active trade requests on deleted trades." do
      worker = CleanerWorker.new
      expect(ActivePokeball.all.count).to eq(3)
      expect(ActiveRequest.all.count).to eq(3)

      worker.perform

      expect(ActivePokeball.all.count).to eq(1)
      expect(ActiveRequest.all.count).to eq(1)
    end
  end
end
