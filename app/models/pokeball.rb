class Pokeball < ApplicationRecord
  belongs_to :user
  belongs_to :pokemon

  validates :description, presence: true
  validates :level, presence: true
  validates :level, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }, allow_blank: true
  validates :hpIV, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 31 }, allow_blank: true
  validates :attIV, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 31 }, allow_blank: true
  validates :defIV, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 31 }, allow_blank: true
  validates :spaIV, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 31 }, allow_blank: true
  validates :spdIV, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 31 }, allow_blank: true
  validates :speIV, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 31 }, allow_blank: true
end
