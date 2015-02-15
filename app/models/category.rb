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
end
