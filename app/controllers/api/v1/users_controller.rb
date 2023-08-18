class Api::V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: users, status: :ok
  end
  def create
    user = User.new(user_params)
    if user.save
      render json: { message: 'User created successfully', data: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      render json: { message: 'User deleted successfully' }, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username)
  end
end
