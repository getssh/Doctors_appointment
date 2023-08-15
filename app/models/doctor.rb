class Doctor < ApplicationRecord
  has_many :reservations, dependent: :destroy

  validates :name, presence: true
  validates :cost_per_session, presence: true
end
