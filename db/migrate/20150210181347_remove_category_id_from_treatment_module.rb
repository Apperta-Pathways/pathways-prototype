class RemoveCategoryIdFromTreatmentModule < ActiveRecord::Migration
  def change
    remove_column :treatment_modules, :category_id, :integer
  end
end
