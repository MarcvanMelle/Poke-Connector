class ActivePokeball < ApplicationRecord
  belongs_to :user
  belongs_to :pokeball
end
