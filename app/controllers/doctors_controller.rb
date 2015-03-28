class DoctorsController < ApplicationController
  before_action :authenticate_doctor!

  before_action :set_doctor, only: [:show, :edit, :update, :destroy, :info]

  def info
    @recent_patients = same_team_patients
    @focused_patient = set_patient
    @treatment_states = TreatmentState.includes(treatment_modules: :data_module).where(pathway: @focused_patient.pathway) unless @focused_patient == nil
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
    @patient = Patient.find_by_id params[:id] unless !@doctor.patients.include?(Patient.find_by_id params[:id])
  end

  def doctor_params
    params[:doctor]
  end

  def same_team_patients
    @doctor.patients
  end

end
