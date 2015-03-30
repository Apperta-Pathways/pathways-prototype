class HomeController < ApplicationController

  def index
    if current_doctor
      redirect_to default_doctor_path
    elsif current_patient
      redirect_to categories_path
    end
  end

  def eula
  end

end


