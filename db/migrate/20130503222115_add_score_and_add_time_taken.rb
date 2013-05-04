class AddScoreAndAddTimeTaken < ActiveRecord::Migration
  add_column :users, :score, :string
  add_column :users, :time_taken, :integer
end
