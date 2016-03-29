class TreatmentStatesController < ApplicationController
  before_action :authenticate_patient!, only: [:index, :show]
  before_action :authenticate_doctor!, only: [:create, :edit, :update]

  before_action :set_state, except: [:create, :index]
  before_action :set_patient, except: [:create]
  before_action :set_most_recent_state, only: [:index]

  def index
    set_category
    @states = TreatmentState.for_category @category, @patient
    render 'treatment_states/show'
  end

  def create
    @patient = Patient.find_by_id(strong_patient_params[:patient_id])
    @state = TreatmentState.new(pathway: @patient.pathway, assigned_date: Time.now)
    @state.save
    # ok to save
    # as it will not show up anywhere because it has no assigned modules

    redirect_to edit_treatment_state_path(@state.id)
  end

  def show
    set_category
    @states = TreatmentState.for_category @category, @patient
    @subcategories = @state.subcategories_of @category
  end

  def edit
    set_active_cat
    @categories = Category.all
  end

  def update
    # When changing date
    if params[:treatment_state]
      @state.update(treatment_state_params)
      flash[:success] = "Date successfully altered"

    # When updating content
    else
      if params[:note]
        puts YAML::dump(@state)
        @state.note = params[:note]
        @state.save
      end
      update_treatment_state
    end

    redirect_to action: 'edit', category_id: params[:category], subcategory_id: params[:subcategory]
  end

  def destroy
    if @state.destroy
      flash[:success] = 'Successfully deleted treatment state'
    else
      flash[:error] = 'Unable to delete treatment state'
    end
    redirect_to :back
  end

  private

  def set_pathway
    @pathway = Pathway.find_by_id(strong_pathway_params)
  end

  def strong_pathway_params
    params.require(:treatment_state).permit(:pathway_id)
  end

  def treatment_state_params
    params.require(:treatment_state).permit(:assigned_date)
  end

  def update_treatment_state
    update_params.each do |data_module_id, v|
      if v == 'no'
        assert_no_treatment_state_exists_for data_module_id
      else
        assert_treatment_state_exists_for data_module_id
      end
    end

    flash[:success] = "Successfully updated treatment state!"
  end

  def assert_no_treatment_state_exists_for(dmID)
    unless @state.has_module_with_id dmID
      return
    end

    TreatmentModule.where(treatment_state_id: @state.id, data_module_id: dmID).first.destroy
  end

  def assert_treatment_state_exists_for(dmID)
    if @state.has_module_with_id dmID
      return
    end

    TreatmentModule.new(data_module_id: dmID, treatment_state: @state).save
  end

  def strong_params
    params.permit(:notes)
    params.permit(:category, :state, :subcategory)
  end

  def update_params
    params.require(:module).permit!
  end

  def set_most_recent_state
    @patient = current_patient
    @state = TreatmentState.most_recent_for_patient(@patient, params[:category_id]) || TreatmentState.for_category(@category, @patient).first

  end

  def set_state
    @state = TreatmentState.find_by_id(params[:id])
  end

  def set_category
    @category = Category.find_by_id(params[:category_id])
    @subcategories = @state.subcategories_of @category
  end

  def strong_patient_params
    params.require(:treatment_state).permit(:patient_id)
  end

  def set_patient
    @patient = current_patient || @state.patient
  end

  def set_active_cat
    if(Category.count > 0)
      @active_cat = Category.includes(:subcategories).find_by_id(params[:category_id]) || Category.first
      set_active_subcat
    end
  end

  def set_active_subcat
    if(Subcategory.count > 0)
      @active_subcat = Subcategory.find_by_id(params[:subcategory_id]) || @active_cat.subcategories.first
    end
  end


end
