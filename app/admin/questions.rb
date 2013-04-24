ActiveAdmin.register Question do
  index do
    column "Question", :question_text
    column "Correct Answer", :correct do |question|
      case question.correct
      when 1
        question.answer1
      when 2
        question.answer2
      when 3
        question.answer3
      when 4
        question.answer4
      end
    end
    column :section
    default_actions
  end
end
