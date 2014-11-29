class TreatmentState < ActiveRecord::Base
  belongs_to :pathway
  has_many :treatment_modules
  validates :timeframe, inclusion: { in: %w(future present past) }
end
