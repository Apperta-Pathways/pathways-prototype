class AddSubcategoryIdToTreatmentModules < ActiveRecord::Migration
  def change
    add_column :treatment_modules, :subcategory_id, :integer
  end
end
