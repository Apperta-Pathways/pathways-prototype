class RemoveSubcategoryIdFromTreatmentModule < ActiveRecord::Migration
  def change
    remove_column :treatment_modules, :subcategory_id, :integer
  end
end
