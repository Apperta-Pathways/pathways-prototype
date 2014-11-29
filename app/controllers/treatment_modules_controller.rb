class TreatmentModulesController < ApplicationController
  before_action :assert_user_exists, only: [:create]

  def all
    @modules = TreatmentModule.all
  end

  def new
    @treatment_module = TreatmentModule.new
  end

  def create
    @t_module = TreatmentModule.new(secure_params)
    @t_module.save
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
