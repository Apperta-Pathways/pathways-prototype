class Category < ActiveRecord::Base
  has_many :subcategories
  has_many :data_modules, through: :subcategories

  alias_attribute :title, :name

  def assigned_tms_in_state(state)
    TreatmentModule.joins(data_module: { subcategory: :category }).where(categories: { id: self.id }, treatment_state_id: state.id)
  end

end
