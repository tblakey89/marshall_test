class RemoveIndexFromUserAnswers < ActiveRecord::Migration
  def change
    remove_index :user_answers, [:user_id, :question_id]
  end
end
