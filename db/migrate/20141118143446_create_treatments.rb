class CreateTreatments < ActiveRecord::Migration
  def change
    create_table :treatment_modules do |t|
      t.string :name
      t.text :description

      t.references :pathway, index: true
      t.timestamps
    end
  end
end
