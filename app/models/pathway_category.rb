class PathwayCategory < ActiveRecord::Base
    belongs_to :pathway
    has_many :treatment_states, -> { order(created_at: :desc) }
end
