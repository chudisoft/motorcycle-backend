# spec/requests/api/reservation_spec.rb
require 'swagger_helper'
require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'GET #index' do
    context 'when user is authenticated' do
      it 'returns a list of user reservations with motorcycle details' do
        admin_user = User.create(email: 'admin@example.com', password: 'password', name: 'Admin User', role: 'admin')
        sign_in admin_user

        motorcycle = Motorcycle.create(name: 'Motorcycle 1', description: 'Fast motorcycle', price: 10.99, user: admin_user,
                                       available: true, image: 'image.jpg')
        # Reservation.create(reserve_time: '12:00',
        #                    reserve_date: '2023-01-01', user: admin_user, :motorcycle)

        get :index
        reservations_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(reservations_response.count).to eq(1)
      end
    end
  end
  describe 'POST #create' do
    context 'when user is authenticated' do
      it 'creates a new reservation' do
        admin_user = User.create(email: 'admin@example.com', password: 'password', name: 'Admin User', role: 'admin')
        sign_in admin_user

        motorcycle = Motorcycle.create(name: 'Motorcycle 1', description: 'Fast motorcycle', price: 10.99, user: admin_user,
                                       available: true, image: 'image.jpg')

        reservation_params = {
          reserve_time: '12:00',
          reserve_date: '2023-01-01'
        }

        post :create, params: { motorcycle_id: motorcycle.id, user_id: admin_user.id, reservation: reservation_params }
        reservation_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(reservation_response['id']).not_to be_nil
      end
    end

    it 'returns status code 401 if user is not authenticated' do
      admin_user = User.create(email: 'admin@example.com', password: 'password', name: 'Admin User', role: 'admin')
      motorcycle = Motorcycle.create(name: 'Motorcycle 1', description: 'Fast motorcycle', price: 10.99, user: admin_user,
                                     available: true, image: 'image.jpg')

      reservation_params = {
        reserve_time: '12:00',
        reserve_date: '2023-01-01'
      }

      post :create, params: { motorcycle_id: motorcycle.id, reservation: reservation_params }
      expect(response).to have_http_status(:unauthorized)
    end
  end
  describe 'DELETE #destroy' do
    it 'deletes the reservation' do
      admin_user = User.create(email: 'admin@example.com', password: 'password', name: 'Admin User', role: 'admin')
      sign_in admin_user

      motorcycle = Motorcycle.create(name: 'Motorcycle 1', description: 'Fast motorcycle', price: 10.99, user: admin_user,
                                     available: true, image: 'image.jpg')
      # reservation = Reservation.create(reserve_time: '12:00',
      #                                  reserve_date: '2023-01-01', user: admin_user, :motorcycle)
      delete :destroy, params: { id: reservation.id }

      expect(response).to have_http_status(:no_content)
      expect { Reservation.find(reservation.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
