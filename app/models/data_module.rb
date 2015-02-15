class DataModule < ActiveRecord::Base
  belongs_to :subcategory
  has_many :treatment_modules
end
