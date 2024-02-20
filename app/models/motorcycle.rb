class Motorcycle < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy

  validates :name, :price, :license_plate, :image, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
