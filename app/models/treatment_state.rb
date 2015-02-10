class TreatmentState < ActiveRecord::Base
  belongs_to :pathway_category
  has_many :treatment_module_subcategories
  validates :timeframe, inclusion: { in: %w(future present past) }
end
