class Request < ApplicationRecord
  belongs_to :user
  belongs_to :pokemon
  has_many :active_requests
  has_many :users, through: :active_requests

  validates :description, presence: true

  scope :expired, -> { where('created_at < ?', Time.zone.now - 7.days) }
end
