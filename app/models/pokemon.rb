class Pokemon < ApplicationRecord
  GENDERS = %w[Male Female Genderless]

  has_many :pokeballs
  has_many :requests

  validates :pokedex_id, uniqueness: true
  validates :name, uniqueness: true
end
