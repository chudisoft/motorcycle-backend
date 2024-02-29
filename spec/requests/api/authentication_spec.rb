# spec/requests/api/login_spec.rb
require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /api/v1/signup' do
    let(:valid_attributes) do
      { user: { name: 'John Doe', email: 'john@example.com', password: 'password' } }
    end

    context 'when the request is valid' do
      before { post '/api/v1/signup', params: valid_attributes }

      it 'creates a new user' do
        expect(response).to have_http_status(:created)
      end

      it 'returns a success message' do
        expect(JSON.parse(response.body)['message']).to eq('User created successfully')
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/signup', params: { user: { name: 'John Doe' } } }

      it 'returns a validation error message' do
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include(
          "Email can't be blank",
          "Password can't be blank",
          'Password is too short (minimum is 6 characters)'
        )
      end
    end
  end

  describe 'POST /api/v1/login' do
    let(:user) { create(:user, email: 'john@example.com', password: 'password') }
    let(:valid_credentials) do
      { user: { email: 'john@example.com', password: 'password' } }
    end

    context 'when the request is valid' do
      before { post '/api/v1/login', params: valid_credentials }

      it 'returns a success status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/login', params: { user: { email: 'khaingg@gmail.com', password: 'in12345' } } }

      it 'returns an authentication error message' do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Invalid email or password')
      end
    end
  end
end
