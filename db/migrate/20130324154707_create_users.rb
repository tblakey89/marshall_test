class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.datetime :dateofbirth
      t.text :aboutme

      t.timestamps
    end
  end
end
