class AddSuperuserFlagToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :superuser, :boolean
  end
end
