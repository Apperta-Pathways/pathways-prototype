class ChangeColumnTypeOfTimeframe < ActiveRecord::Migration
  def change
    change_column :treatment_states, :timeframe, :string
  end
end
