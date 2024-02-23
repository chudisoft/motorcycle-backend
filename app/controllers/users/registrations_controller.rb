class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :configure_sign_up_params, only: [:create]

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation admin])
  end

  private

  def respond_with(resource, _opts = {})
    if request.method == 'POST' && resource.persisted?
      user = User.find_by(email: params[:user][:email])

      if user
        user.generate_jwt
        render json: {
          token: user.generate_jwt,
          status: { code: 200, message: 'Signed up sucessfully.' },
          data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
        }, status: :ok
      else
        render json: {
          status: { code: 422, message: "User couldn't be created successfully.
          #{resource.errors.full_messages.to_sentence}" }
        }, status: :unprocessable_entity
      end
    elsif request.method == 'DELETE'
      render json: {
        status: { code: 200, message: 'Account deleted successfully.' }
      }, status: :ok
    else
      render json: {
        status: { code: 422, message: "User couldn't be created successfully.
        #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
end
