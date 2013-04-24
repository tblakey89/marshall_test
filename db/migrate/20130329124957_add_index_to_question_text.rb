class AddIndexToQuestionText < ActiveRecord::Migration
  def change
    add_index :questions, :question_text, unique: true
  end
end
