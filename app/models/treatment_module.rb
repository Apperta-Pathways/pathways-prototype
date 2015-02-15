class TreatmentModule < ActiveRecord::Base
  belongs_to :treatment_state
  belongs_to :data_module

  delegate :title, to: :data_module
  delegate :data, to: :data_module

  delegate :subcategory, to: :data_module
  delegate :category, to: :data_module

  def category
    self.data_module.subcategory.category
  end


end
