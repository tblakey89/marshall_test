class ConvertScoreFromStringToInteger < ActiveRecord::Migration
  def up
    change_column :users, :score, :integer
  end

  def down
    change_column :users, :score, :string
  end
end
