class Api::V1::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      token = @user.generate_jwt
      @user.save
      render json: { success: true, message: 'user was created successfully', token: }, status: :created
    else
      render json: { error: true, message: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:user][:email])

    if user&.valid_password?(params[:user][:password])
      token = user.generate_jwt
      render json: { user_id: user.id, name: user.name, message: 'logged in successfully', token: }, status: :created
    else
      render json: { error: true, message: 'something is wrong' }, status: :ok
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :email, :password_confirmation)
  end
end
