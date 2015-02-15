class CategoriesController < ApplicationController
  before_action :authenticate_patient!
  before_action :set_patient

  def show
    @category = Category.find_by(id: params[:id])

    if @category.nil?
      redirect_to patients_url and return
    end

    @treatment_state = params[:treatment_state] || present_treatment_state

    if(@treatment_state.nil? || TreatmentState.find_by(id:@treatment_state).nil? || !TreatmentState.find_by(id:@treatment_state).categories.include?(@category))
       redirect_to patients_url and return
    end
  end

  private

  def set_patient
    @patient = Patient.find(current_patient)
  end

  def present_treatment_state
    id = nil
    @patient.pathway.treatment_states.each do |i|
      if (i.categories.include? @category) && i.timeframe == "present"
        return i.id
      end
      if i.categories.include? @category
        id = i.id
      end
    end
    return id
  end
end
