class FixJobTitle < ActiveRecord::Migration

  remove_column :users, :jot_title
  add_column :users, :job_title, :string

end
