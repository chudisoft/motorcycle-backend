class Api::V1::AuthenticationController < ApplicationController
  def login
    user = User.find_by(email: params[:user][:email])

    if user&.authenticate(params[:user][:password])
      token = user.generate_jwt
      render json: {
        user_id: user.id, name: user.name,
        message: 'Logged in successfully', role: user.role, token:
      }, status: :created
    else
      render json: { error: true, message: 'Invalid email or password' }, status: :ok
    end
  end
end
