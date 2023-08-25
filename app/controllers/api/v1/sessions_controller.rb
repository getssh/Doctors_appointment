class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    if user
      render json: user, status: :ok
    else
      render json: { message: 'User not found' }, status: :not_found
    end
  end
end
