class CreateTreatmentStates < ActiveRecord::Migration
  def change
    create_table :treatment_states do |t|
      t.integer :timeframe
      t.belongs_to :pathway, index: true

      t.timestamps
    end
  end
end
