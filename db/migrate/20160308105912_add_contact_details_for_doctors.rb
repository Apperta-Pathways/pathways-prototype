class AddContactDetailsForDoctors < ActiveRecord::Migration
  def change
      add_column :doctors, :contact_details, :string
  end
end
