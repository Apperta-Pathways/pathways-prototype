class AddNameToDataModules < ActiveRecord::Migration
  def change
    add_column :data_modules, :title, :string
  end
end
