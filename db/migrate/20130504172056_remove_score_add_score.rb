class RemoveScoreAddScore < ActiveRecord::Migration

  remove_column :users, :score
  add_column :users, :score, :integer

end
