class Api::V1::ReservationsController < ApplicationController
  def index
    user = User.find_by(username: params[:user_username])
    if user.present?
      reservations = Reservation.includes(:doctor).where(user:)
      if reservations.present?
        data = reservations.as_json(include: :doctor)
        render json: { status: 'SUCCESS', message: 'Loaded all reservations', data: }, status: :ok
      else
        render json: { status: 'ERROR', message: 'This user does not have reservations' }, status: :unprocessable_entity
      end
    else
      render json: { status: 'ERROR', message: 'User not found' }, status: :unprocessable_entity
    end
  end

  def create
    reservation = Reservation.new(reservation_params)
    user = User.find_by(username: params[:user_username])
    doctor = Doctor.find(params[:doctor_id])
    reservation.user = user
    reservation.doctor = doctor

    if reservation.save
      render json: { status: 'SUCCESS', message: 'Reservation saved', data: reservation }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Reservation not saved', data: reservation.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    reservation = Reservation.find_by(id: params[:id])

    if reservation.nil?
      return render json: { status: 'ERROR', message: 'Reservation does not exist' }, status: :unprocessable_entity
    end

    if reservation.destroy
      render json: { status: 'SUCCESS', message: 'Deleted reservation', data: reservation }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Reservation not deleted', data: reservation.errors },
             status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.permit(:start_date, :end_date, :city, :status, :cost, :doctor_id, :user_id)
  end
end
