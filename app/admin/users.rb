ActiveAdmin.register User do
  show do
    panel "User Details" do
      attributes_table_for user do
        row("username") { user.username }
        row("email") { user.email }
      end
    end

    panel "Questions" do
      table_for user.user_answers do |t|
        t.column("Question") { |user_answer| user_answer.question.question_text }
        t.column("Correct") { |user_answer| status_tag (user_answer.answer == user_answer.question.correct ? "Correct" : "False")}
      end
    end
  end
end
