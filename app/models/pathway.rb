class Pathway < ActiveRecord::Base
  belongs_to :patient
  has_many :pathway_categories
end
