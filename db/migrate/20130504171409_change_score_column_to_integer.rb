class ChangeScoreColumnToInteger < ActiveRecord::Migration

  change_column :users, :score, :integer

end
