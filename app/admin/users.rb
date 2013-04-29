ActiveAdmin.register User do
  show do
    panel "User Details" do
      attributes_table_for user do
        row("username") { user.username }
        row("email") { user.email }
      end
    end

    panel "Questions" do
      table_for UserAnswer.find(:all, :conditions => "user_id=" + user.id.to_s, :group => "question_id") do |t|
        t.column("Question") { |user_answer| user_answer.question.question_text }
        t.column("Answer") { |user_answer| status_tag (user_answer.answer == user_answer.question.correct ? "Correct" : "Incorrect")}
        t.column("Attempts") { |user_answer| UserAnswer.count(:conditions => "question_id =" + user_answer.question_id.to_s + " AND user_id=" + user.id.to_s)}
        t.column("Section") { |user_answer| user_answer.question.section.name }
      end
    end
  end
end
