class TreatmentStatesController < ApplicationController
  before_action :set_state

  def new

  end

  def edit
    set_active_cat
    @categories = Category.all
  end

  def update
    update_treatment_state

    redirect_to action: 'edit', state: @state.id, category: params[:category], subcategory: params[:subcategory]
  end

  private

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
    params.permit(:category, :state, :subcategory);
  end

  def update_params
    params.require(:module).permit!
  end

  def set_state
    @state = TreatmentState.find_by_id(strong_params[:state])
  end

  def set_active_cat
    @active_cat = Category.includes(:subcategories).find_by_id(strong_params[:category])
    set_active_subcat if @active_cat
  end

  def set_active_subcat
    @active_subcat = Subcategory.find_by_id(strong_params[:subcategory])
  end

end

