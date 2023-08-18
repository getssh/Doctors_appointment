class Api::V1::DoctorsController < ApplicationController
  def index
    doctors = Doctor.all
    if doctors.empty?
      render json: { status: 'ERROR', message: 'Doctors not found' }, status: :unprocessable_entity
    else
      render json: { status: 'SUCCESS', message: 'Loaded all doctors', data: doctors }, status: :ok
    end
  end

  def create
    doctor = Doctor.new(doctor_params)
    if doctor.save
      render json: { status: 'SUCCESS', message: 'Saved doctor', data: doctor }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Doctor not saved', data: doctor.errors }, status: :unprocessable_entity
    end
  end

  def show
    doctor = Doctor.find(params[:id])
    render json: { status: 'SUCCESS', message: 'Loaded doctor', data: doctor }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { status: 'ERROR', message: 'Doctor does not exist' }, status: :unprocessable_entity
  end

  def destroy
    doctor = Doctor.find(params[:id])
    doctor.destroy
    render json: { status: 'SUCCESS', message: 'Doctor deleted', data: doctor }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { status: 'ERROR', message: 'Doctor does not exist' }, status: :unprocessable_entity
  end

  private

  def doctor_params
    params.permit(:name, :description, :specialization, :cost_per_session, :image_url)
  end
end
