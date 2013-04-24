class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.integer :user_id
      t.integer :question_id
      t.integer :answer
      t.timestamps
    end

    add_index :user_answers, :user_id
    add_index :user_answers, :question_id
    add_index :user_answers, [:user_id, :question_id], unique: true
  end
end
