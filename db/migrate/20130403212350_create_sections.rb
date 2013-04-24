class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :order
      t.string :name

      t.timestamps
    end

    add_index :sections, :name, unique: true
  end
end
