class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(_resource, _opts = {})
    user = User.find_by(email: params[:user][:email])

    if user&.valid_password?(params[:user][:password])
      token = user.generate_jwt
      render json: {
        data: UserSerializer.new(user).serializable_hash[:data][:attributes],
        message: 'Logged in successfully', token:,
        status: :created
      }
    else
      render json: { error: true, message: 'Invalid email or password' }, status: :ok
    end
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split[1],
                             Rails.application.credentials.fetch(:secret_key_base)).first
    current_user = User.find(jwt_payload['sub'])
    if current_user
      render json: {
        status: 200,
        message: 'logged out successfully'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
