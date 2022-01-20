class User < ApplicationRecord
  has_many :pokeballs
  has_many :requests
  has_many :active_requests
  has_many :active_pokeballs

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true
  validates_uniqueness_of :username
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_format_of :friend_code, with: /\d{4}-\d{4}-\d{4}/, message: "must be in \"0000-0000-0000\" format", allow_nil: true
end
