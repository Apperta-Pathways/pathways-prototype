class Pathway < ActiveRecord::Base
  belongs_to :patient
  has_many :treatment_states, -> { order('created_at') }, dependent: :destroy
end
