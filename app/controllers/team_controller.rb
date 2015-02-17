class TeamController < ApplicationController

  def create
  end
  
  def index
  end
  
  def show
    @team = Team.find_by(id: params[:id])
  end
end
