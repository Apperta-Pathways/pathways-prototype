class AddFieldsToState < ActiveRecord::Migration
  def change
    add_column :treatment_states, :default, :boolean
    add_column :treatment_states, :assigned_date, :date
  end
end
