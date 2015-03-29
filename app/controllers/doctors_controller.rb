class DoctorsController < ApplicationController
  before_action :authenticate_doctor!

  before_action :set_doctor, only: [:show, :edit, :update, :destroy, :info]
  before_action :set_patient, only: [:info]

  def info
    @recent_patients = same_team_patients
    @focused_patient = @patient
    @treatment_states = @patient.treatment_states
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
    @doctor = current_doctor
  end

  def set_patient
    @patient = Patient.find_by_id params[:id] if @doctor.patients.include?(Patient.find_by_id params[:id])
  end

  def doctor_params
    params[:doctor]
  end

  def same_team_patients
    @doctor.patients
  end

end
