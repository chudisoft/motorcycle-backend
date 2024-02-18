class User < ApplicationRecord
  has_many :reservations
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates_presence_of :name, :email
  validates :email, uniqueness: true
end
