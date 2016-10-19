require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.create(username: "PokeMaster1987", first_name: "Ash", last_name: "Ketchum", email: "pokemaster@pikachu.net", password: "pik4pi!", friend_code: "1234-5678-9011") }

  # Testing for custom user variables not included in devise

  describe "#username" do
    it "should return the user's display name" do
      expect(user.username).to eq("PokeMaster1987")
    end
  end

  describe "#first_name" do
    it "should return the user's name" do
      expect(user.first_name).to eq("Ash")
    end
  end

  describe "#last_name" do
    it "should return the user's last name" do
      expect(user.last_name).to eq("Ketchum")
    end
  end

  describe "#email" do
    it "should return the user's display name" do
      expect(user.email).to eq("pokemaster@pikachu.net")
    end
  end

  describe "#friend_code" do
    it "should return the user's display name" do
      expect(user.friend_code).to eq("1234-5678-9011")
    end
  end
end
