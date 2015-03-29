class DoctorsController < ApplicationController
  before_action :authenticate_doctor!

  before_action :set_doctor, only: [:show, :edit, :update, :destroy, :info, :reset_password]
  before_action :assert_superuser, only: [:edit, :update, :destroy, :new]
  before_action :set_patient, only: [:info]

  def info
    @recent_patients = current_doctor.patients.order(:updated_at)
    @treatment_states = @patient.treatment_states if @patient
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
    flash[:success] = "Successfully created new account for #{@doctor.name}"

    redirect_to '/admin'
  end

  def update
    params[:doctor][:confirm_password] = params[:doctor][:password]
    @doctor.update(doctor_params)

    flash[:success] = "Successfully updated account for #{@doctor.name}"
    redirect_to doctors_path
  end

  def destroy
    @doctor.destroy
    respond_with(@doctor)
  end

  def reset_password
    set_random_password_for @doctor
    flash.now[:success] = "Successfully reset password"
    render '/doctors/created'
  end

  def search
    @doctor = Doctor.find_by_email(params[:email])
    unless @doctor
      flash[:error] = "No doctor with that email was found"
      redirect_to doctors_path and return
    end
    render :edit
  end

  private

  def set_random_password_for(doctor)
    @password = Faker::Lorem.words(2).join('-')
    doctor.password = @password
    doctor.password_confirmation = @password
    doctor.save
  end

  def set_patient
    @patient = Patient.find_by_id(params[:id])
  end

  def set_treatment_states
    if(@focused_patient)
      @treatment_states = TreatmentState.includes(treatment_modules: :data_module).where(pathway: @focused_patient.pathway)
    end
  end

  def set_doctor
    @doctor = Doctor.find_by_id(params[:id]) || current_doctor
  end

  def doctor_params
    params.require(:doctor).permit(:name, :email, :superuser, :password, team_ids: [])
  end

  def assign_patients
    @doctor.patients
  end

  def assert_superuser
    unless current_doctor.superuser
      flash[:error] = 'You do not have permission to access this page'
      redirect_to doctor_hub_path
    end
  end

end
