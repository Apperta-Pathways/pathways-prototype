class AddDataToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :name, :string

    add_column :patients, :nhs_number, :integer
    add_index :patients, :nhs_number

  end
end
