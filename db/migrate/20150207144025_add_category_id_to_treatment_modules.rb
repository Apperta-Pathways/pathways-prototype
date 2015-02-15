class AddCategoryIdToTreatmentModules < ActiveRecord::Migration
  def change
    add_column :treatment_modules, :category_id, :integer
  end
end
