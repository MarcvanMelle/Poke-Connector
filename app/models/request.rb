class Request < ApplicationRecord
  belongs_to :user
  belongs_to :pokemon

  validates :description, presence: true
end
