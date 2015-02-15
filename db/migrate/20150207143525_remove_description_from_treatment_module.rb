class RemoveDescriptionFromTreatmentModule < ActiveRecord::Migration
  def change
    remove_column :treatment_modules, :description, :text
  end
end
