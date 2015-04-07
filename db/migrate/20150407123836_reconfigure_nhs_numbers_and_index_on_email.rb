class ReconfigureNhsNumbersAndIndexOnEmail < ActiveRecord::Migration
  def change
    remove_index :patients, :email
    add_index :patients, :email

    change_column :patients, :nhs_number, :string
  end
end
