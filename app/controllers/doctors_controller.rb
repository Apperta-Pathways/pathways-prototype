class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :edit, :update, :destroy]

  def info
    @recent_patients = Patient.recent
    @focused_patient = Patient.includes(pathway: { treatment_states: :treatment_modules }).where(treatment_states: { timeframe: 'present' }).find_by_id(params[:id])
    if @focused_patient
      @current_modules = @focused_patient.treatment_states.first.treatment_modules
    end
  end

  def show
    respond_with(@doctor)
  end

  def new
    @doctor = Doctor.new
    respond_with(@doctor)
  end

  def edit
  end

  def create
    @doctor = Doctor.new(doctor_params)
    @doctor.save
    respond_with(@doctor)
  end

  def update
    @doctor.update(doctor_params)
    respond_with(@doctor)
  end

  def destroy
    @doctor.destroy
    respond_with(@doctor)
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def doctor_params
    params[:doctor]
  end
end
