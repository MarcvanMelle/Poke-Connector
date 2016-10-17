require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  #Testing for custom user methods not included in devise

  describe "#username" do
    it "should return the user's display name" do
      expect(user.username).to eq("PokeMaster1")
    end
  end

  describe "#first_name" do
    it "should return the user's name" do
      expect(user.first_name).to eq("Ash2")
    end
  end

  describe "#last_name" do
    it "should return the user's last name" do
      expect(user.last_name).to eq("Ketchum3")
    end
  end

  describe "#email" do
    it "should return the user's display name" do
      expect(user.email).to eq("ashketchum4@pokemon.com")
    end
  end

  describe "#friend_code" do
    it "should return the user's display name" do
      expect(user.friend_code).to eq("0000-0000-0005")
    end
  end
end
