class TreatmentModulesController < ApplicationController
  # before_action :assert_user_exists, only: [:create]
  before_action :authenticate_doctor!

  def all
    @t_modules = TreatmentModule.all
  end

  def new
    @categories = Categories.all
    @treatment_module = TreatmentModule.new
  end

  def create
    @t_module = TreatmentModule.new(secure_params)
    @user = Patient.find_by_email('test@test.com')
    @t_module.treatment_state = @user.treatment_states.first
    @t_module.save
    @t_modules = TreatmentModule.all
    render action: "all"
  end

  private

  def assert_user_exists
    if User.find_by_id(secure_params[:id])
      true
    end
    false
  end

  def secure_params
    params.require(:treatment_module).permit(:name, :description, :user_id)
  end
end
