class RemoveNameFromTreatmentModule < ActiveRecord::Migration
  def change
    remove_column :treatment_modules, :name, :string
  end
end
