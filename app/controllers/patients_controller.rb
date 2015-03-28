class PatientsController < ApplicationController
  before_action :authenticate_doctor!, except: [:new]

  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def show
    @patient = Patient.find_by_id params[:id]
    respond_with(@patient)
  end

  def new
    @patient = Patient.new
    respond_with(@patient)
  end

  def edit
  end

  def search
    @patient = Patient.find_by_nhs_number(params[:nhs_number])
    redirect_to doctor_hub_path @patient.id and return if @patient
    flash[:error] = "No patient found with NHS number #{params[:nhs_number]}"
    redirect_to :back
  end

  def create
    @patient = Patient.new(patient_params)
    set_random_password_for @patient
    @patient.save

    flash[:success] = "Successfully created patient"
    flash[:new_password] = @password
    render 'created'
  end

  def update
    @patient.update(patient_params)
    respond_with(@patient)
  end

  def destroy
    @patient.destroy
    respond_with(@patient)
  end

  def reset_password
    set_random_password_for @patient
    flash[:success] = "Successfully reset password"
    flash[:new_password] = @password
    render 'created'
  end

  private

  def set_random_password_for(patient)
    @password = Faker::Lorem.words(2).join('-')
    patient.password = @password
    patient.password_confirmation = @password
  end

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def current_modules_of(patient)
    @patient.treatment_states.first.treatment_modules
  end

  def patient_params
    params.require(:patient).permit(:name, :nhs_number, :email)
  end
end
