class TreatmentModuleSubcategory < ActiveRecord::Base
    belongs_to :treatment_state
    has_many :treatment_modules
end
