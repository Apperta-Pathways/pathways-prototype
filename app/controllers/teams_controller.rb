class TeamsController < ApplicationController
  before_action :authenticate_doctor!
  before_action :set_team, only: [:destroy, :show, :update]
  before_action :assert_superuser, only: [:index, :create, :show, :destroy]

  def index
    @teams = Team.all
  end

  def create
    @team = Team.new(strong_params)

    if @team.save
      flash[:success] = "A new team has successfully been created!"
    end

    redirect_to teams_url
  end

  def show
  end

  def update
    set_target

    if(params[:action_request] == "remove")
      remove_member
      flash[:success] = "#{@target.capitalize} successfully removed" 
    end

    if(params[:action_request] == "add")
      if params[:add_member][:email]
        add_doctor
      elsif params[:add_member][:nhs_number]
        add_patient
      end
    end

    redirect_to @team
  end

  def destroy
    @team.destroy
    flash[:success] = "Team successfully deleted!"
    redirect_to teams_url
  end

  private

  def remove_member
    @member = convert_into_class(@target).find_by_id params[:content]
    @team.send(@target.pluralize).delete(@member)
  end

  def add_patient
    @patient = Patient.find_by_nhs_number(params[:add_member][:nhs_number])
    @team.patients << @patient

  end

  def add_doctor
    @doctor = Doctor.find_by_email(params[:add_member][:email])
    @team.doctors << @doctor
  end

  def set_team
    @team = Team.find_by(id: params[:id])
  end

  def strong_params
    params.require(:team).permit(:name, :description);
  end

  def set_target
    @target = params[:target]
  end

  def convert_into_class(string)
    string.capitalize.constantize
  end

end
