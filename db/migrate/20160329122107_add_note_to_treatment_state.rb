class AddNoteToTreatmentState < ActiveRecord::Migration
  def change
      add_column :treatment_states, :note, :text
  end
end
