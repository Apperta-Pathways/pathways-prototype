class TreatmentModule < ActiveRecord::Base
  belongs_to :treatment_state
  has_one :category
end
