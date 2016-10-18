class User < ApplicationRecord
  has_many :pokeballs
  has_many :pokemons, through: :pokeballs

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true
  validates_uniqueness_of :username
  validates :first_name, presence: true
  validates :last_name, presence: true
end
