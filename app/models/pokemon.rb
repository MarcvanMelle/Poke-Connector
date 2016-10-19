class Pokemon < ApplicationRecord
  has_many :pokeballs
  has_many :requests
end
