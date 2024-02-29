require 'swagger_helper'
require 'rails_helper'

RSpec.describe Api::V1::MotorcyclesController, type: :request do
  let(:valid_attributes) do
    { user: { name: 'John Doe', email: 'john@example.com', password: 'password' } }
  end

  describe 'GET #index' do
    before do
      post '/api/v1/signup', params: valid_attributes
      token = JSON.parse(response.body)['token']
      @headers = { 'Authorization' => "Bearer #{token}" }
    end

    it 'returns a list of motorcycles' do
      get '/api/v1/motorcycles', headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    before do
      post '/api/v1/signup', params: valid_attributes
      token = JSON.parse(response.body)['token']
      @headers = { 'Authorization' => "Bearer #{token}" }
    end

    it 'creates a new motorcycle' do
      motorcycle_params = { make: 'Honda', model: 'CBR', year: 2022, color: 'Black', license_plate: 'ABC123',
                            image: 'image.jpg', price: 10_000.00 }
      post '/api/v1/motorcycles', params: { motorcycle: motorcycle_params }, headers: @headers
      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE #destroy' do
    before do
      post '/api/v1/signup', params: valid_attributes
      token = JSON.parse(response.body)['token']
      @headers = { 'Authorization' => "Bearer #{token}" }
    end

    it 'deletes a motorcycle' do
      motorcycle = Motorcycle.create(make: 'Honda', model: 'CBR', year: '2024-02-24', color: 'Black',
                                     license_plate: 'ABC123', image: 'image.jpg', price: 10_000.00)
      delete "/api/v1/motorcycles/#{motorcycle.id}", headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end
end
