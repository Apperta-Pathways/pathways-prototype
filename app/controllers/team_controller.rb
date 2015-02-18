class TeamController < ApplicationController
  
  def add
    if(params[:typeAdded] == 'Patient' && !Patient.find_by(email: params[:team_member][:email]).nil?)
      Team.find_by(id:params[:id]).patients << [Patient.find_by(email: params[:team_member][:email])]
    end
    
    if(params[:typeAdded] == 'Doctor' && !Doctor.find_by(email: params[:team_member][:email]).nil?)
      Team.find_by(id:params[:id]).doctors << [Doctor.find_by(email: params[:team_member][:email])]
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
