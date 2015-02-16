class Subcategory < ActiveRecord::Base
  belongs_to :category
  has_many :data_modules

  def assigned_tms_in_state(state)
    TreatmentModule.joins(data_module: :subcategory).where(subcategories: { id: self.id }, treatment_state_id: state.id)
  end
end
