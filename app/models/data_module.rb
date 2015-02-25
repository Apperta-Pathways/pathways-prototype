class DataModule < ActiveRecord::Base
  belongs_to :subcategory
  has_many :treatment_modules

  delegate :category, to: :subcategory

  has_many :treatment_states

  def preview
    /<p>([\w]*)<\/p>/.match(self.data) || self.data
  end

end
