class CreateDataModules < ActiveRecord::Migration
  def change
    create_table :data_modules do |t|
      t.text :data
      t.references :subcategory, index: true

      t.timestamps
    end
  end
end
