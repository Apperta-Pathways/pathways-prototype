class AddDataModuleIdToTreatmentModules < ActiveRecord::Migration
  def change
    add_column :treatment_modules, :data_module_id, :integer
  end
end
