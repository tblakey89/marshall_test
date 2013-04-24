class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string :name

      t.timestamps
    end

    add_index :exams, :name, :unique
  end
end
