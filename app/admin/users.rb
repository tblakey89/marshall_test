ActiveAdmin.register User do
  config.comments = false

  filter :first_name
  filter :last_name
  filter :dealership
  filter :job_title
  filter :email

  index do
    column :first_name
    column :last_name
    column :email
    column :job_title
    column :dealership
    column :created_at
    column :score
    column "Time Taken", :the_time
    default_actions
  end

  show do
    panel "User Details" do
      attributes_table_for user do
        row("first_name") { user.first_name }
        row("last_name") { user.last_name }
        row("email") { user.email }
        row("job_title") { user.job_title }
        row("dealership") { user.dealership }
        row("score") { user.score }
        row("time_taken") { user.the_time }
      end
    end

    panel "Questions" do
     table_for UserAnswer.find(:all, conditions: "user_id=" + user.id.to_s, select: "DISTINCT ON (question_id) *", order: "question_id, created_at desc") do |t|
     #table_for UserAnswer.find(:all, conditions: "user_id=" + user.id.to_s, group: "question_id", order: "question_id") do |t|
        t.column("Question") { |user_answer| link_to user_answer.question.question_text, admin_question_path(user_answer.question) }
        t.column("Answer") { |user_answer| status_tag (user_answer.answer == user_answer.question.correct ? "Correct" : "Incorrect")}
        t.column("Attempts") { |user_answer| UserAnswer.count(:conditions => "question_id =" + user_answer.question_id.to_s + " AND user_id=" + user.id.to_s)}
        t.column("Section") { |user_answer| link_to user_answer.question.section.name, admin_section_path(user_answer.question.section) }
      end
    end
  end
end
