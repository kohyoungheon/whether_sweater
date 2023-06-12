class Api::V0::SessionsController < ApplicationController
  def create
    user = User.find_by(email: user_params[:email].downcase)
    if user && user.authenticate(user_params[:password])
      render json: UserSerializer.new(user).serialize, status: 200
    else
      render json: {errors: ["Invalid email or password"]}, status: 400
    end
  end

  private
  def user_params
    params.permit(:email, :password)
  end
end