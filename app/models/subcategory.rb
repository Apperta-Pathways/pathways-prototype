class Subcategory < ActiveRecord::Base
  belongs_to :category
  has_many :data_modules
end
