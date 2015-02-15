class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_patient!

  def index
    @patient = Patient.find(current_patient)
    @categories = Category.categories_of @patient
    # @current_state = @patient.treatment_states.first.treatment_modules
  end

  def show
    respond_with(@patient)
  end

  def new
    @patient = Patient.new
    respond_with(@patient)
  end

  def edit
  end

  def create
    @patient = Patient.new(patient_params)
    @patient.save
    respond_with(@patient)
  end

  def update
    @patient.update(patient_params)
    respond_with(@patient)
  end

  def destroy
    @patient.destroy
    respond_with(@patient)
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def current_modules_of(patient)
    @patient.treatment_states.first.treatment_modules
  end

  def patient_params
    params[:patient]
  end
end
