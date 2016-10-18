require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryGirl.create(:user) }

  # Testing for custom user methods not included in devise
  # Note: if running tests on only this file change
        # values to reflect FactoryGirl's broken sequence

  describe "#username" do
    it "should return the user's display name" do
      expect(user.username).to eq("PokeMaster22")
    end
  end

  describe "#first_name" do
    it "should return the user's name" do
      expect(user.first_name).to eq("Ash36")
    end
  end

  describe "#last_name" do
    it "should return the user's last name" do
      expect(user.last_name).to eq("Ketchum37")
    end
  end

  describe "#email" do
    it "should return the user's display name" do
      expect(user.email).to eq("ashketchum25@pokemon.com")
    end
  end

  describe "#friend_code" do
    it "should return the user's display name" do
      expect(user.friend_code).to eq("0000-0000-0039")
    end
  end
end
