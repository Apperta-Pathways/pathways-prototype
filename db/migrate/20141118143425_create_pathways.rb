class CreatePathways < ActiveRecord::Migration
  def change
    create_table :pathways do |t|
      t.references :user, index: true
      t.string :disease
      t.timestamps
    end
  end
end
