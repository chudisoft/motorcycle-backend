# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#generate_jwt' do
    it 'generates a JWT token' do
      user = User.new(id: 1)
      jwt = user.generate_jwt
      decoded = JWT.decode(jwt, Rails.application.secret_key_base)[0]
      expect(decoded['id']).to eq(user.id)
    end
  end

  describe '.from_jwt' do
    it 'decodes a JWT token and returns the user id' do
      user = User.create(id: 1)
      jwt = JWT.encode({ id: user.id }, Rails.application.secret_key_base)
      decoded_id = User.from_jwt(jwt)
      expect(decoded_id).to eq(user.id)
    end
  end
end
