class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :motorcycle

  validates :reserve_time, :reserve_date, presence: true
end
