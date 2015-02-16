class Category < ActiveRecord::Base
  has_many :subcategories
  has_many :data_modules, through: :subcategories

  alias_attribute :title, :name

  def self.categories_of(patient)
    Category.joins(subcategories:
                   { data_modules:
                     { treatment_modules:
                       { treatment_state: {
                          pathway: :patient }}}}).where(patients: { id: patient.id })
  end

  def assigned_tms_in_state(state)
    TreatmentModule.joins(data_module: { subcategory: :category }).where(categories: { id: self.id }, treatment_state_id: state.id)
  end

end
