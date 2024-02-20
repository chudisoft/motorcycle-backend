class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :rememberable,
          :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :reservations
  has_many :motorcycles, through: :reservations

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def generate_jwt
    JWT.encode({ id: self.id, exp: 60.days.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end

  def self.from_jwt(token)
    decoded = JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')[0]
    find_by(id: decoded['id'])
  end

  enum role: { user: 'user', admin: 'admin' }

  def is?(requested_role)
    role == requested_role.to_s
  end
end
