ActiveAdmin.register Question do
  scope :all, :default => true
  scope :Section_1 do |questions|
    questions.where('section_id=1')
  end
  scope :Section_2 do |questions|
    questions.where('section_id=2')
  end
  scope :Section_3 do |questions|
    questions.where('section_id=3')
  end
  scope :Section_4 do |questions|
    questions.where('section_id=4')
  end
  scope :Section_5 do |questions|
    questions.where('section_id=5')
  end

  filter :section
  filter :question_text

  controller do
    actions :all, :except => [:destroy, :new]
  end

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

  form do |f|
    f.inputs "Details" do
      f.input :question_text
      f.input :answer1
      f.input :answer2
      f.input :answer3
      f.input :answer4
      f.input :correct
    end
    f.actions
  end
end
