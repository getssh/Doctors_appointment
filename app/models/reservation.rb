class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :doctor

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :user_id, presence: true
  validates :doctor_id, presence: true
end
