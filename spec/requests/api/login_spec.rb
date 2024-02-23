require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'User Sessions API', type: :request do
  describe 'POST /login' do
    let(:user) { User.create(email: 'test@example.com', password: 'password', name: 'John Doe') }

    it 'logs in successfully with valid credentials' do
      post '/login', params: { user: { email: user.email, password: 'password' } }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['status']['code']).to eq(200)
      expect(JSON.parse(response.body)['data']['name']).to eq(user.name)
    end

    it 'returns an error with invalid credentials' do
      post '/login', params: { user: { email: user.email, password: 'wrong_password' } }

      expect(response).to have_http_status(:unauthorized)
    end

    it 'logs out successfully' do
      user = User.create(email: 'test@example.com', password: 'password', name: 'John Doe')
      post '/login', params: { user: { email: user.email, password: 'password' } }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['status']['code']).to eq(200)
      token = response.headers['Authorization']&.split&.last
      expect(token).to be_present
      headers = { 'Authorization' => "Bearer #{token}" }

      delete('/logout', headers:)
      expect(response).to have_http_status(:ok)
    end
  end
end
