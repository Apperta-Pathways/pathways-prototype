class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.text :description

      t.timestamps
    end

    create_join_table :teams, :patients do |t|
      t.index :team_id
      t.index :patient_id
    end

    create_join_table :teams, :doctors do |t|
      t.index :team_id
      t.index :doctor_id
    end

  end
end
