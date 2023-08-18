class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true
  has_many :reservations, dependent: :destroy
end
