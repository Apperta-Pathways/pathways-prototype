class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_patient!

  def index
    @patient = Patient.find(current_patient)
    @categories = Category.categories_of @patient
    # @current_state = @patient.treatment_states.first.treatment_modules
  end

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