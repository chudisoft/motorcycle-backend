# spec/requests/api/signup_spec.rb
require 'swagger_helper'
require 'rails_helper'

RSpec.describe 'User Registrations API', type: :request do
  path '/signup' do
    post 'user created' do
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          name: { type: :string }
        },
        required: %w[email password name]
      }

      response '422', 'unprocessable entity' do
        let(:user) { { email: '', password: '', name: '' } }
        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['status']['code']).to eq(422)
        end
      end
    end
  end
end
