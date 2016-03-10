class AddLockToDataModules < ActiveRecord::Migration
  def change
      add_column :data_modules, :locked, :boolean, :default => false
  end
end
