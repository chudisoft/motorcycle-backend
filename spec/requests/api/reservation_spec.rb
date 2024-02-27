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

    it 'returns a list of reservations' do
      get '/api/v1/reservations', headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    before do
      post '/api/v1/signup', params: valid_attributes
      token = JSON.parse(response.body)['token']
      @headers = { 'Authorization' => "Bearer #{token}" }
    end

    it 'creates a new reservation' do
      motorcycle = Motorcycle.create(make: 'Honda', model: 'CBR', year: '2024-02-24', color: 'Black',
                                     license_plate: 'ABC123', image: 'image.jpg', price: 10_000.00)
      reservation_params = { motorcycle_id: motorcycle.id, city: 'Thaton', reserve_date: '2024-02-24',
                             reserve_time: '02:00' }
      post '/api/v1/reservations', params: { reservation: reservation_params }, headers: @headers
      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE #destroy' do
    before do
      post '/api/v1/signup', params: valid_attributes
      token = JSON.parse(response.body)['token']
      @headers = { 'Authorization' => "Bearer #{token}" }
    end

    it 'deletes a reservation' do
      motorcycle = Motorcycle.create(make: 'Honda', model: 'CBR', year: Date.parse('2024-02-24'), color: 'Black',
                                     license_plate: 'ABC123', image: 'image.jpg', price: 10_000.00)
      reservation_params = { motorcycle_id: motorcycle.id, city: 'Thaton', reserve_date: '2024-02-24',
                             reserve_time: '02:00' }

      # Create the reservation
      post '/api/v1/reservations', params: { reservation: reservation_params }, headers: @headers

      reservation = Reservation.find_by(motorcycle_id: motorcycle.id, city: 'Thaton', reserve_date: '2024-02-24',
                                        reserve_time: '02:00')

      # Delete the reservation
      delete "/api/v1/reservations/#{reservation.id}", headers: @headers

      expect(response).to have_http_status(:ok)
    end
  end
end
