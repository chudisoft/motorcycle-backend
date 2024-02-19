class User < ApplicationRecord
  has_many :reservations
  has_many :motorcycles, through: :reservations
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_presence_of :name
  validates :email, presence: true, uniqueness: true
  def generate_jwt
    JWT.encode({ user_id: id }, Rails.application.secrets.secret_key_base)
  end

  def self.from_jwt(token)
    decoded = JWT.decode(token, Rails.application.secret_key_base)[0]
    find(decoded['id'])
  end

  enum role: { user: 'user', admin: 'admin' }

  def is?(requested_role)
    role == requested_role.to_s
  end
end
