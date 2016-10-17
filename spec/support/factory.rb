require 'factory_girl_rails'

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "PokeMaster#{n}" }
    sequence(:email) { |n| "ashketchum#{n}@pokemon.com" }
    password "pikachu12345"
    password_confirmation "pikachu12345"
    sequence(:first_name) { |n| "Ash#{n}" }
    sequence(:last_name) { |n| "Ketchum#{n}" }
    sequence(:friend_code) { |n| "0000-0000-000#{n}"}
    factory :admin do
      admin true
    end
  end
end
