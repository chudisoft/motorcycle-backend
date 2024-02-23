# spec/requests/api/motorcycle_spec.rb
require 'swagger_helper'
require 'rails_helper'

RSpec.describe Api::V1::MotorcyclesController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'GET #index' do
    context 'when user is an admin' do
      it 'returns a list of all motorcycles' do
        admin_user = User.create(email: 'admin@example.com', password: 'password', name: 'Admin User', role: 'admin')
        sign_in admin_user

        Motorcycle.create(name: 'Motorcycle 1', description: 'Fast motorcycle',
                          price: 10.99, user: admin_user,
                          available: true, image: 'image.jpg')
        Motorcycle.create(name: 'Motorcycle 2', description: 'Another fast motorcycle',
                          price: 12.99, user: admin_user,
                          available: true, image: 'image.jpg')
        Motorcycle.create(name: 'Motorcycle 3', description: 'Yummy byke', price: 8.99,
                          user: admin_user, available: true,
                          image: 'image.jpg')

        get :index
        motorcycles_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(motorcycles_response.count).to eq(2)
      end
    end

    context 'when user is not an admin' do
      it 'returns a list of available motorcycles' do
        admin_user = User.create(email: 'admin@example.com', password: 'password', name: 'Admin User', role: 'admin')
        normal_user = User.create(email: 'user@example.com', password: 'password', name: 'Normal User', role: 'user')
        sign_in normal_user

        # Create available motorcycles for normal user
        Motorcycle.create(name: 'Motorcycle 1', description: 'Fast motorcycle', price: 10.99, user: admin_user,
                          available: true, image: 'image.png')
        Motorcycle.create(name: 'Motorcycle 2', description: 'Another fast motorcycle', price: 12.99, user: admin_user,
                          available: true, image: 'image.png')

        get :index
        motorcycles_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(motorcycles_response.count).to eq(2) # Only available motorcycles for normal user
      end
    end
  end

  describe 'POST #create' do
    it 'creates a new motorcycle' do
      admin_user = User.create(email: 'admin@example.com', password: 'password', name: 'Admin User', role: 'admin')
      sign_in admin_user

      motorcycle_params = {
        name: 'New Motorcycle',
        description: 'Fast motorcycle description',
        price: 9.99,
        available: true,
        image: 'motorcycle.jpg'
      }

      post :create, params: { motorcycle: motorcycle_params }
      expect(response).to have_http_status(:created)
      expect(Motorcycle.count).to eq(1)
    end

    it 'returns status code 401 if user is not authenticated' do
      motorcycle_params = {
        name: 'New Motorcycle',
        description: 'Fast motorcycle description',
        price: 9.99,
        available: true,
        image: 'motorcycle.jpg',
        license_plate: 'AX220D'
      }

      post :create, params: { motorcycle: motorcycle_params }
      expect(response).to have_http_status(:unauthorized)
      expect(Motorcycle.count).to eq(0)
    end
  end
end
