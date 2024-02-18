require 'rails_helper'

RSpec.describe 'API::V1::Users', type: :request do
  describe 'POST /signup' do
    it 'creates a new user' do
      post 'http://localhost:3000/api/v1/signup', params: { user: { name: 'maypyone', email: 'test@example.com', password: 'password', password_confirmation: 'password' } }
      expect(response).to have_http_status(:created)
      expect(response.body).to include('User created successfully')
    end
  end

  describe 'POST /login' do
    it 'logs in an existing user' do
      user = User.create(email: 'test@example.com', password: 'password', password_confirmation: 'password')
      post '/api/v1/login', params: { email: 'test@example.com', password: 'password' }
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Login successful')
    end

    it 'returns an error for invalid login' do
      post '/api/v1/login', params: { email: 'invalid@example.com', password: 'password' }
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to include('Invalid email or password')
    end
  end
end
