class Api::V0::UsersController < ApplicationController
  def create
    user_params[:email] = user_params[:email].downcase
    user = User.new(email: user_params[:email], password: user_params[:password], password_confirmation: user_params[:password_confirmation], api_key: SecureRandom.hex(13))
    if user.save
      render json: UserSerializer.new(user).serialize, status: 201
    else
      render json: {errors: user.errors.full_messages}, status: 400
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation, :api_key)
  end

end