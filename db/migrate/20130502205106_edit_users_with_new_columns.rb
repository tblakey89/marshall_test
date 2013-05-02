class EditUsersWithNewColumns < ActiveRecord::Migration
  remove_column :users, :password_digest, :aboutme, :dateofbirth
  add_column :users, :dealership_id, :integer
  add_column :users, :jot_title, :string
end
