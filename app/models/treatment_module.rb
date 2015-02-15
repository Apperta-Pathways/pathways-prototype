class TreatmentModule < ActiveRecord::Base
  belongs_to :treatment_state
  belongs_to :data_module
end
