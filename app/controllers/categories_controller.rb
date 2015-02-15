class CategoriesController < ApplicationController
  def show
    @patient = Patient.find(current_patient)
    
    @category = Category.find_by(id:params[:id])
    if(@category.nil?)
      redirect_to patients_url and return
    end
    
    @treatment_state = params[:treatment_state] || present_treatment_state
    if(@treatment_state.nil? || TreatmentState.find_by(id:@treatment_state).nil?)
       redirect_to patients_url and return
    end
  end
  
  private
  
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
