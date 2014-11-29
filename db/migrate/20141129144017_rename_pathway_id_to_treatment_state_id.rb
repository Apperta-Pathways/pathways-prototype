class RenamePathwayIdToTreatmentStateId < ActiveRecord::Migration
  def change
    rename_column :treatment_modules, :pathway_id, :treatment_state_id
  end
end
