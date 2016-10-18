require 'factory_girl_rails'

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "PokeMaster#{n}" }
    sequence(:email) { |n| "ashketchum#{n}@pokemon.com" }
    password "pikachu12345"
    password_confirmation "pikachu12345"
    sequence(:first_name) { |n| "Ash#{n}" }
    sequence(:last_name) { |n| "Ketchum#{n}" }
    sequence(:friend_code) { |n|
      if n < 10
        "0000-0000-000#{n}"
      else
        "0000-0000-00#{n}"
      end
      }
    factory :admin do
      admin true
    end
  end

  factory :pokeball do
    sequence(:description) { |n| "Short Desc#{n}"}
    level 50
    hpIV 0
    attIV 0
    defIV 0
    spaIV 0
    spdIV 0
    speIV 0
  end
end
