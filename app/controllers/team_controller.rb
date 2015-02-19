class TeamController < ApplicationController
  
  def destroy
    Team.find_by(id:params[:id]).destroy
    redirect_to teams_url
  end
  
  def add
    @team = Team.find_by(id:params[:id])
    @patient = Patient.find_by(email: params[:team_member][:email])
    @doctor = Doctor.find_by(email: params[:team_member][:email])
    
    if(params[:typeAdded] == 'Patient' && !@patient.nil? && !@team.patients.include?(@patient))
      @team.patients << [@patient]
    end
    
    if(params[:typeAdded] == 'Doctor' && !@doctor.nil? && !@team.doctors.include?(@doctor))
      @team.doctors << [@doctor]
    end
    
    redirect_to Team.find_by(id: params[:id])
  end

  def create
  end
  
  def index
  end
  
  def show
    @team = Team.find_by(id: params[:id])
  end
  
  def remove
    if(!params[:patient].nil?)
      Team.find_by(id:params[:id]).patients -= [Patient.find_by(id: params[:patient])]
    end
    
    if(!params[:doctor].nil?)
      Team.find_by(id:params[:id]).doctors -= [Doctor.find_by(id: params[:doctor])]
    end
    
    redirect_to Team.find_by(id: params[:id])
  end
end
