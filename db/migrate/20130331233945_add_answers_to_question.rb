class AddAnswersToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :answer1, :text
    add_column :questions, :answer2, :text
    add_column :questions, :answer3, :text
    add_column :questions, :answer4, :text
    add_column :questions, :correct, :integer
  end
end
